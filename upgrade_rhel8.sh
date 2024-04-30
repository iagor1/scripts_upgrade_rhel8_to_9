#!/bin/bash

Leapp_Pre_Upgrade(){
dnf install leapp-upgrade -y
leapp preupgrade
cat /var/log/leapp/leapp-report.txt
}

Fixing_Inhibitors(){

echo 'Fixing : Inhibitor Firewalld Configuration AllowZoneDrifting Is Unsupported setting allozonedrifting to no in firewalld.conf'
Fixing_AllowZoneDrifting

echo 'Fixing : Packages signed with SHA-1 cannot be installed or upgraded'
update-crypto-policies --set LEGACY

echo 'answering questions from leapp about VDO devices'
leapp answer --section check_vdo.confirm=True

echo 'Fixing : Possible problems with remote login using root account '
Fixing_Root_Login

echo "Fixing duplicate repo if exists change the name in the function"
Fixing_Duplicate_Repo
}

Fixing_Duplicate_Repo(){
if [ -a /etc/yum.repos.d/zabbix-non-supported.repo ];then
  echo "removing zabbix-non-suported"
  rm -rf /etc/yum.repos.d/zabbix-non-supported.repo
else
  echo "file not found, skipping..."
fi
}

Fixing_AllowZoneDrifting(){
allowzone=$(cat /etc/firewalld/firewalld.conf | grep -E '^\AllowZoneDrifting=yes$')
if [ -z "$allowzone" ]; then
  echo "AllowZoneDrifting set to no, skipping..."
else
  echo "Changing AllowZoneDrifting to no"
  sed -i "s/^AllowZoneDrifting=.*/AllowZoneDrifting=no/" /etc/firewalld/firewalld.conf
fi

}

Fixing_Root_Login(){
rootloginfile=$(cat /etc/ssh/sshd_config | grep -E '^\PermitRootLogin\s+yes$')
if [ -z "$rootloginfile" ]; then
  echo "PermitRootLogin already commented, skipping..."
else
  echo "Commenting PermitRootLogin in sshd_config"
  sed -i '/PermitRootLogin yes/s/^/#/' /etc/ssh/sshd_config
  systemctl restart sshd
fi
}

Leapp_Upgrade(){
echo 'running upgrade...'
leapp upgrade
}

Leapp_Pre_Upgrade
Fixing_Inhibitors
Leapp_Upgrade

echo 'rebooting system now...'
reboot
