
gw:
  group.present: []
  user.present:
    - shell: /bin/bash
    - home: /home/gw
    - remove_groups: False
    - groups:
      - gw
      - users

rynge:
  group.present: []
  user.present:
    - shell: /bin/bash
    - home: /home/rynge
    - groups:
      - rynge
      - users
      - wheel

linsal:
  group.present: []
  user.present:
    - shell: /bin/bash
    - home: /home/linsal
    - groups:
      - linsal
      - users
      - wheel

