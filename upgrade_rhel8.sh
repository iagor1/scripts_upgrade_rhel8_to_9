#!/bin/bash

Leapp_Pre_Upgrade(){
dnf install leapp-upgrade -y
leapp preupgrade
cat /var/log/leapp/leapp-report.txt
}
Fixing_Inhibitors(){
echo 'Fixing : Inhibitor Firewalld Configuration AllowZoneDrifting Is Unsupported setting allozonedrifting to no in firewalld.conf'
sed -i "s/^AllowZoneDrifting=.*/AllowZoneDrifting=no/" /etc/firewalld/firewalld.conf
echo 'Fixing : Packages signed with SHA-1 cannot be installed or upgraded'
update-crypto-policies --set LEGACY
echo 'answering questions from leapp about VDO devices'
leapp answer --section check_vdo.confirm=True
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