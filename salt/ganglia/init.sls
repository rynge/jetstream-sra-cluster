

gmond:
  pkg:
    - installed
    - name: ganglia-gmond
  service.running:
    - enable: True
    - watch:
      - file: /etc/ganglia/gmond.conf


/etc/ganglia/gmond.conf:
  file.managed:
    - source: salt://ganglia/gmond.conf


/etc/ganglia/gmetad.conf:
  file.managed:
    - source: salt://ganglia/gmetad.conf

/usr/lib/systemd/system/gmond.service:
  file:
    - managed
    - source: salt://ganglia/gmond.service

