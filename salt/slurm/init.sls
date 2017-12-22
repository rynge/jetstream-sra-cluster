
munge:
  pkg:
    - installed
  service.running:
    - enable: True
    - watch:
      - file: /etc/munge/munge.key

/etc/munge/munge.key:
  file:
    - managed
    - user: munge
    - group: munge
    - mode: 400
    - source: salt://local-conf/munge.key

slurm:
  group:
    - present
  user.present:
    - groups:
      - slurm

/var/log/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/var/spool/slurm:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/var/spool/slurmd:
  file.directory:
    - user: slurm
    - group: slurm
    - mode: 755

/etc/slurm/slurm.conf:
  file:
    - managed
    - user: slurm
    - group: slurm
    - mode: 644
    - source: salt://slurm/slurm.conf

/etc/slurm/slurmdbd.conf:
  file:
    - managed
    - user: slurm
    - group: slurm
    - mode: 600
    - source: salt://slurm/slurmdbd.conf

slurmctld:
  service.running:
    - enable: True
    - watch:
      - file: /etc/slurm/slurm.conf
      - file: /etc/slurm/slurmdbd.conf

slurmd:
  service.running:
    - enable: True
    - watch:
      - file: /etc/slurm/slurm.conf


