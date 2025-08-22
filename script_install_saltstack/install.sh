#!/usr/bin/env bash

#Correct timezone

echo -e "\nSetting timezone\n"
timedatectl set-timezone Europe/Moscow

#Install useful tools

apt update && apt install -y curl vim

#Add info of repo SaltStack

curl -fsSL https://packages.broadcom.com/artifactory/api/security/keypair/SaltProjectKey/public | tee /etc/apt/keyrings/salt-archive-keyring.pgp &> /dev/null
curl -fsSL https://github.com/saltstack/salt-install-guide/releases/latest/download/salt.sources | tee /etc/apt/sources.list.d/salt.sources &> /dev/null

apt update

cat > /etc/apt/preferences.d/salt-pin-1001 <<EOF
Package: salt-*
Pin: version 3006.*
Pin-Priority: 1001
EOF

#Install packages SaltStack

while true; do
    echo -e "What role do you want to install:\n1. salt-master\n2. salt-minion\n3. nothing\n"
    read -p "Enter the number: " num
    echo
    case $num in
        [1]* )
            apt update && apt install salt-master -y
            break
            ;;
        [2]* )
            apt update && apt install salt-minion -y
            break 
            ;;
        [3]* )
            break
            ;;
        * )
            echo "Enter the correct number: "
            ;;
    esac
done