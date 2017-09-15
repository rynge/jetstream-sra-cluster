#!/usr/bin/env python

import time
import re
import shade
import datetime

from pprint import pprint

# Initialize and turn on debug logging
#shade.simple_logging(debug=True)

# Initialize cloud
# Cloud configs are read with os-client-config
cloud = shade.openstack_cloud(cloud='jetstream_iu')

#flavor = cloud.get_flavor_by_ram(512)
#pprint(flavor)

count_running = 0

# clean out shutdown machines
print("Checking on VMs in the system ... ")
for server in cloud.list_servers():

    # needed for mixed environments
    if not re.match("^sra-", server.name):
        continue
    
    if not re.match("^sra-worker", server.name):
        continue
    
    print(" ... %s (%s)" %(server.name, server.status))
    
    if server.status == "ACTIVE":
        count_running += 1

    if server.status == "SHUTOFF" or server.status == "ERROR":
        # remove the server
        print("     ... deleting server")
        cloud.delete_server(server)


# do we need more workers?
if count_running < 1:

    image_selected = None
    for i in cloud.list_images():
        
        if not re.match("^sra-base-", i.name):
            continue

        if image_selected is None or \
           i.name > image_selected.name:
            image_selected = i

    print("Selected %s for this instance" %(image_selected.name))
    
    flavor = cloud.get_flavor("m1.small")

    network = cloud.get_network("sra-network")

    #secgroup = nova.security_groups.find(name="default")

    dt = datetime.datetime.now()
    name = "sra-worker-%s" %(dt.strftime("%Y%m%d%H%M%S"))

    print("Starting a new instance with name %s" %(name))
    cloud.create_server(name, \
                        image=image_selected, \
                        flavor=flavor, \
                        network=network, \
                        auto_ip=False)


