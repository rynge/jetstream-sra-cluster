
/etc/yum.repos.d/htcondor-stable-rhel7.repo:
  file:
    - managed
    - source: salt://htcondor/htcondor-stable-rhel7.repo

condor:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - file: /etc/condor/config.d/10-jetstream.conf
      - file: /etc/condor/config.d/50-manager.conf
      - file: /etc/condor/pool_password


/etc/condor/config.d/50-manager.conf:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://local-conf/htcondor-50-manager.conf

/etc/condor/pool_password:
  file:
    - managed
    - user: root
    - mode: 600
    - source: salt://local-conf/htcondor-pool_password

/usr/lib/systemd/system/condor.service:
  file:
    - managed
    - source: salt://htcondor/worker.condor.service


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


