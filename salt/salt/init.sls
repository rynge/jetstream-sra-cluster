
/usr/lib/systemd/system/salt-on-boot.service:
  file:
    - managed
    - source: salt://salt/salt-on-boot.service

salt-on-boot:
  service:
    - enabled

salt-minion:
  service.running:
    - enable: True
    - watch:
      - file: /etc/salt/minion.d/50-custom.conf

/etc/salt/minion.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/etc/salt/minion.d/50-custom.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://salt/50-custom.conf

/etc/salt/minion.d/50-master.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://local-conf/salt-50-master.conf

/etc/cron.d/salt:
  file.managed:
    - source: salt://salt/cron.salt
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/usr/lib/nagios/plugins:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/usr/lib/nagios/plugins/check_salt_highstate:
  file.managed:
    - source: salt://salt/check_salt_highstate
    - user: root
    - group: root
    - mode: 755

