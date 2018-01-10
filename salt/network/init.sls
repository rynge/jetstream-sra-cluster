
/etc/sysconfig/network-scripts/ifcfg-eth0:
  file:
    - managed
    - source: salt://network/ifcfg-eth0

/etc/sysconfig/network-scripts/ifcfg-eth1:
  file:
    - managed
    - source: salt://network/ifcfg-eth1

iptables:
  service:
    - disabled

# conflicts with our dhcpd setup - disable the service
NetworkManager:
  service:
    - disabled
    
network:
  service:
    - enabled

/etc/hosts:
  file:
    - managed
    - source: salt://local-conf/hosts
    - user: root
    - group: root
    - mode: 644

