
/usr/lib/systemd/system/gmond.service:
  file:
    - managed
    - source: salt://ganglia/gmond.service

gmond:
  pkg:
    - installed
    - name: ganglia-gmond
  service:
    - enabled

#  service.running:
#    - enable: True
#    - watch:
#      - file: /etc/ganglia/gmond.conf

/etc/ganglia/gmond.conf:
  file.managed:
    - source: salt://ganglia/gmond.conf


{% if 'master' in salt['grains.get']('roles', []) %}

gmetad:
  pkg:
    - installed
    - name: ganglia-gmetad
  service.running:
    - enable: True
    - watch:
      - file: /etc/ganglia/gmetad.conf

/etc/ganglia/gmetad.conf:
  file.managed:
    - source: salt://ganglia/gmetad.conf

ganglia-web:
  pkg:
    - installed

{% else %}

ganglia-gmetad:
  pkg:
    - removed

{% endif %}
