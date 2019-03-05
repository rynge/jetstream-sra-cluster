{% if 'master' in salt['grains.get']('roles', []) %}

nfs-server:
  service.running:
    - enable: True
    - watch:
      - file: /etc/exports

nfs-lock:
  service.running:
    - enable: True

nfs-idmap:
  service.running:
    - enable: True

/etc/exports:
  file:
    - managed
    - source:
      - salt://nfs/exports
    - user: root
    - group: root
    - mode: 644


{% endif %}

