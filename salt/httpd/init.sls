
{% if 'master' in salt['grains.get']('roles', []) %}

httpd:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - file: /etc/httpd/conf/httpd.conf

/etc/httpd/conf/httpd.conf:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://httpd/httpd.conf

/srv/web:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/srv/web/results:
  file.directory:
    - mode: 1777

/srv/web/index.html:
  file:
    - managed
    - mode: 644
    - source: salt://httpd/index.html

/srv/web/results/index.html:
  file:
    - managed
    - mode: 644
    - source: salt://httpd/index.html

tmpwatch:
  pkg:
    - installed

/etc/cron.d/tmpwatch-results:
  file:
    - managed
    - user: root
    - mode: 644
    - source: salt://httpd/tmpwatch-results.cron

{% endif %}

