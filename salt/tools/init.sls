

/usr/sbin/jetstream-prep-for-imaging:
  file:
    - managed
    - source: salt://tools/jetstream-prep-for-imaging
    - user: root
    - group: root
    - mode: 755


{% if 'master' in salt['grains.get']('roles', []) %}

/etc/cron.d/sra-report-to-es:
  file:
    - managed
    - source: salt://tools/sra-report-to-es.cron
    - user: root
    - group: root
    - mode: 644

{% endif %}

