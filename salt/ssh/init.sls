
sshd:
  pkg:
    - installed
    - name: openssh-server
  service.running:
    - enable: True
    - sig: sshd
    - require:
      - pkg: openssh-server


