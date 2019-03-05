#!/usr/bin/env python

import time
import re
import shade
import datetime
import subprocess

from datetime import datetime, timedelta
from dateutil import parser, tz
from pprint import pprint


# consts
MAX_INSTANCES_TOTAL = 21
MAX_INSTANCES_PER_ITERAION = 3


def backticks(cmd):
    return subprocess.Popen(cmd, shell=True, stdout=subprocess.PIPE).communicate()[0]

# Initialize and turn on debug logging
#shade.simple_logging(debug=True)

# Initialize cloud from ~/.config/openstack/clouds.yml
cloud = shade.openstack_cloud(cloud='jetstream_iu')

servers_running = 0

# clean out shutdown machines
print("Checking on VMs in the system ... ")
for server in cloud.list_servers():

    # needed for mixed environments
    if not re.match("^sra-", server.name):
        continue
    
    if not re.match("^sra-worker", server.name):
        continue

    last_update = parser.parse(server.updated, ignoretz=True)
    now = datetime.utcnow()
    
    print(" ... %s (%s, last update %s)" %(server.name, server.status, str(last_update)))

    if server.status == "SHUTOFF" or server.status == "ERROR":
        # remove the server
        print("     ... deleting server")
        cloud.delete_server(server)
        continue
    
    # sometimes the instances get stuck in BUILD state
    if server.status == "BUILD" and last_update < now - timedelta(days=1):
        # remove the server
        print("     ... deleting server")
        cloud.delete_server(server)
        continue
    
    # just stuck
    if last_update < now - timedelta(days=2):
        # remove the server
        print("     ... seems stuck, deleting server")
        cloud.delete_server(server)
        continue
    
    if server.status == "ACTIVE" or server.status == "BUILD":
        servers_running += 1
        continue

print("%d servers running" %(servers_running))

# how many idle jobs do we have?
jobs_idle = backticks("condor_q -const 'JobStatus == 1' -nob -allusers -af ClusterID -af ProcID | wc -l")
if jobs_idle == None or jobs_idle == "":
    print("Unable to query HTCondor")
    sys.exit(1)
jobs_idle = int(jobs_idle)
print("%d idle HTCondor jobs" %(jobs_idle))

# how many "old" idle jobs do we have?
jobs_old_idle = backticks("condor_q -const 'JobStatus == 1 && time() - QDate > 900' -nob -allusers -af ClusterID -af ProcID | wc -l")
if jobs_old_idle == None or jobs_old_idle == "":
    print("Unable to query HTCondor")
    sys.exit(1)
jobs_old_idle = int(jobs_old_idle)
print("%d \"old\" idle HTCondor jobs" %(jobs_old_idle))

# do we need more workers?
# we want to start quickly, but then be more conservative in order to not oversubscribe
new_instances_count = 0
if servers_running < 3 and jobs_idle > 0:
    new_instances_count = int(jobs_idle / 10)
    if new_instances_count < 1:
        new_instances_count = 1
elif jobs_old_idle > 30:
    new_instances_count = 3

# bounds
new_instances_count = min(new_instances_count, MAX_INSTANCES_PER_ITERAION)
if MAX_INSTANCES_TOTAL - servers_running < new_instances_count:
    new_instances_count = MAX_INSTANCES_TOTAL - servers_running
if servers_running >= MAX_INSTANCES_TOTAL:
    new_instances_count = 0

print("Starting %d new servers" %(new_instances_count))

for i in range(new_instances_count):

    image_selected = None
    for i in cloud.list_images():
        
        if not re.match("^sra-base-", i.name):
            continue

        if image_selected is None or \
           i.name > image_selected.name:
            image_selected = i

    print("Selected %s for a new instance" %(image_selected.name))
    
    flavor = cloud.get_flavor("m1.large")

    network = []
    network.append(cloud.get_network("sra-net"))
    network.append(cloud.get_network("sra-wrangler"))

    # sleep to make sure this is a unique ts
    time.sleep(2)

    dt = datetime.now()
    name = "sra-worker-%s" %(dt.strftime("%Y%m%d%H%M%S"))

    # create the user data script
    # sometimes we get .novalocal and sometimes .openstacklocal hostnames
    cmd = "/srv/jetstream-sra-cluster/salt/tools/sra-create-worker-bootstrap" + \
          " /tmp/" + name + \
          " " + name + ".jetstreamlocal" + \
          " " + name + ".openstacklocal" 
    backticks(cmd)

    f = open("/tmp/" + name, "r")
    user_data = f.read()
    f.close()

    print("Starting a new instance with name %s" %(name))
    cloud.create_server(name, \
                        image=image_selected, \
                        flavor=flavor, \
                        network=network, \
                        auto_ip=False, \
                        userdata=user_data)

print('All done')

