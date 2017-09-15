

/usr/sbin/jetstream-prep-for-imaging:
  file:
    - managed
    - source: salt://tools/jetstream-prep-for-imaging
    - user: root
    - group: root
    - mode: 755

