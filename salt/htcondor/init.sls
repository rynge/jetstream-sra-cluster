
/etc/yum.repos.d/htcondor-stable-rhel7.repo:
  file:
    - managed
    - source: salt://htcondor/htcondor-stable-rhel7.repo

condor:
  pkg:
    - installed
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/condor/config.d/10-jetstream.conf
      - file: /etc/condor/config.d/50-manager.conf
      - file: /etc/condor/pool_password

/var/lib/condor-job-history:
  file.directory:
    - user: condor
    - group: condor
    - mode: 1777

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

/usr/bin/sra-htcondor-ads:
  file:
    - managed
    - mode: 755
    - source: salt://htcondor/sra-htcondor-ads

{% if 'master' in salt['grains.get']('roles', []) %}
#######################################################################
##
## master configs
##
/etc/condor/config.d/10-jetstream.conf:
  file:
    - managed
    - source: salt://htcondor/10-jetstream-master.conf

{% else %}
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

{% endif %}


