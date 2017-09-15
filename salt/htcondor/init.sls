
/etc/yum/repos.d/htcondor-stable-rhel7.repo:
  file:
    - managed
    - source: salt://htcondor/htcondor-stable-rhel7.repo

condor:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - /etc/condor/config.d/10-jetstream.conf


#/etc/condor/pool_password:
#  file:
#    - managed
#    - user: root
#    - mode: 600
#    - source: salt://htcondor/default/pool_password


{% if 'worker_node' in salt['grains.get']('roles', []) %}
#######################################################################
##
## worker configs
##

/etc/condor/config.d/10-jetstream.conf:
  file:
    - managed
    - source: salt://htcondor/10-jetstream-worker.conf

/etc/condor/master_shutdown_script.sh:
  file:
    - managed
    - mode: 755
    - source: salt://htcondor/master_shutdown_script.sh

/usr/lib/systemd/system/condor.service:
  file:
    - managed
    - source: salt://htcondor/worker.condor.service

{% else %}
#######################################################################
##
## master configs
##

/etc/condor/config.d/10-jetstream.conf:
  file:
    - managed
    - source: salt://htcondor/10-jetstream-master.conf


{% endif %}


