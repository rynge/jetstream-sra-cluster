
nginx:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - file: /etc/nginx/nginx.conf

/etc/nginx/nginx.conf:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://nginx/nginx.conf

/srv/web:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/srv/web/results:
  file.directory:
    - user: root
    - group: root
    - mode: 1777

/srv/web/index.html:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://nginx/index.html

/srv/web/results/index.html:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://nginx/index.html

tmpwatch:
  pkg:
    - installed

/etc/cron.d/tmpwatch-results:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://nginx/tmpwatch-results.cron


