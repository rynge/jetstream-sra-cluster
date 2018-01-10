
/etc/sysconfig/network-scripts/ifcfg-eth0:
  file:
    - managed
    - source: salt://network/ifcfg-eth0

/etc/sysconfig/network-scripts/ifcfg-eth1:
  file:
    - managed
    - source: salt://network/ifcfg-eth1

# conflicts with our dhcpd setup - disable the service
NetworkManager:
  service:
    - disabled
    
network:
  service:
    - enabled

