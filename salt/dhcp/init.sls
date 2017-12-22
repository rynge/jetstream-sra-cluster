
/etc/dhcp/dhclient.conf:
  file.managed:
    - source: salt://dhcp/dhclient.conf

/etc/dhcp/dhclient-exit-hooks.d/jetstream-wrangler.sh:
  file:
    - managed
    - source: salt://dhcp/jetstream-wrangler.sh
    - user: root
    - group: root
    - mode: 755


