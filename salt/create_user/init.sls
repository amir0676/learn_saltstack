install_packages:
  pkg.installed:
    - name: sudo
    - refresh: True

{% for user, args in pillar.get('users', {}).items() %}
create_user_{{ user }}:
  user.present:
    - name: {{ user }}
    - shell: /bin/bash
    - home: /home/{{ user }}
    - usergroup: True
    - groups:
      - sudo
      - docker
    - password: $5$RuI3sbCLhqVeklrS$McdSqu1lUYH9zatUdbGlyLabiEIqwReBVwlw46gPYA2

ssh_authorized_keys_{{ user }}:
  ssh_auth.present:
    - user: {{ user }}
    - names:
      {% for key in args.get('ssh_keys', []) %}
        - {{ key }}
      {% endfor %}
    - require:
        - user: create_user_{{ user }}
{% endfor %}
