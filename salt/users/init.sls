
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
    - home: /nas/home/rynge
    - groups:
      - rynge
      - users
      - wheel

linsal:
  group.present: []
  user.present:
    - shell: /bin/bash
    - home: /nas/home/linsal
    - groups:
      - linsal
      - users
      - wheel

