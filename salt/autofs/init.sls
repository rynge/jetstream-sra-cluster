autofs:
  pkg:
    - installed
    - name: autofs
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/auto.master
      - file: /etc/auto.nas

/nas:
  file.directory:
    - user: root
    - group: root
    - mode: 755

/etc/auto.master:
  file.managed:
    - source: salt://autofs/auto.master

/etc/auto.nas:
  file.managed:
   - source: salt://autofs/auto.nas

