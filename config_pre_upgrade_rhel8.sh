#!/bin/bash
Check_System(){
echo 'run after register system with subscription-manager register'
subscription-manager status
subscription-manager list --installed
subscription-manager release --list
cat /etc/redhat-release
}

Comment_Nfs_Connections(){
echo 'commenting nfs lines in fstab'
sed -i '/nfs/s/^/#/' /etc/fstab
#sed : qq linha que tiver nfs e add um comentario (#) no começo da linha com o ^
echo 'checking VDO devices'
lsblk -o NAME,TYPE,FSTYPE,SIZE | grep vdo
}

Enable_Repos(){
subscription-manager repos --enable rhel-8-for-x86_64-baseos-rpms --enable rhel-8-for-x86_64-appstream-rpms
subscription-manager release --set 8.9
dnf update -y
}

Check_System
Comment_Nfs_Connections
Enable_Repos

echo 'rebooting system now...'
reboot