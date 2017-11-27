
/etc/cron.d/wrangler-fix:
  file.managed:
    - source: salt://wrangler-fix/cron.wrangler-fix
    - user: root
    - group: root
    - mode: 644
    - template: jinja

/usr/sbin/wrangler-fix.sh:
  file.managed:
    - source: salt://wrangler-fix/wrangler-fix.sh
    - user: root
    - group: root
    - mode: 755

