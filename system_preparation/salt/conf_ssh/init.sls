install_openssh_server:
  pkg.installed:
    - name: openssh-server
    - refresh: True

change_conf_openssh:
  file.managed:
    - name: /etc/ssh/sshd_config
    - source: salt://conf_ssh/sshd_config
    - require:
        - pkg: install_openssh_server

restart_service:
  service.running:
    - name: sshd
    - enable: True
    - watch:
        - file: change_conf_openssh
