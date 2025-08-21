create_nodeusr:
  user.present:
    - name: nodeusr
    - createhome: Fasle
    - shell: /bin/false
    - usergroup: True

add_binary_file_node_exporter:
  file.managed:
    - name: /usr/local/bin/node_exporter
    - source: salt://install_node_exporter/node_exporter
    - mode: 700
    - user: nodeusr
    - group: nodeusr

create_systemd_module_node_exporter:
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - source: salt://install_node_exporter/node_exporter.service
    - mode: 644
    - user: root
    - group: root
    - require:
        - file: add_binary_file_node_exporter

reboot_systemd_daemon:
  module.run:
    - name: cmd.run
    - cmd: systemd daemon-reload

start_node_exporter_service:
  service.running:
    - name: node_exporter
    - enable: True
