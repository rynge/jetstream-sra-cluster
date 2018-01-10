
/etc/dhcp/dhclient.conf:
  file.managed:
    - source: salt://dhcp/dhclient.conf

/etc/dhcp/dhclient-enter-hooks:
  file:
    - managed
    - source: salt://dhcp/dhclient-enter-hooks
    - user: root
    - group: root
    - mode: 755

/etc/dhcp/dhclient-exit-hooks:
  file:
    - managed
    - source: salt://dhcp/dhclient-exit-hooks
    - user: root
    - group: root
    - mode: 755

