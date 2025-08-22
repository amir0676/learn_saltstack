install_useful_packages:
  pkg.installed:
    - pkgs:
        - curl 
        - software-properties-common 
        - ca-certificates 
        - apt-transport-https
        - gnupg

download_gpg_keys:
  cmd.run:
    - name: wget -O- https://download.docker.com/linux/debian/gpg | gpg --dearmor > /etc/apt/keyrings/docker.gpg
    - require:
        - pkg: install_useful_packages

add_repo_docker:
  pkgrepo.managed:
    - humanname: Docker
    - name: deb [arch={{ grains['osarch'] }} signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian {{ grains['oscodename'] }} stable
    - file: /etc/apt/sources.list.d/docker.list
    - reqire:
        - cmd: download_gpg_keys
    
install_docker:
  pkg.installed:
    - name: docker-ce
    - require:
        - pkgrepo: add_repo_docker
    - refresh: True
