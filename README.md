# RHEL 8 to RHEL 9 Upgrade Shell Scripts

## Description
This repository contains shell scripts designed to facilitate the upgrade process from RHEL 8 to RHEL 9.3 

First of all, to update rhel 8 to rhel 9.3 your server need to be in 8.9 to use leapp upgrade. With this command `subscription-manager release --set 8.9` after that we need to update with dnf.

#### About Leapp Warnings, i cant make sure the warning i got will be the same. In this scripts i fixed the following Inhibitors :
- Leapp inhibitor detected rpms with rsa/sha1 signature
- Inhibitor: cannot perform the vdo check of block devices
- Inhibitor: Firewalld Configuration AllowZoneDrifting Is Unsupported

## Features
- Automated upgrade process: The scripts automate the execution of key steps required to upgrade from RHEL 8 to RHEL 9, reducing manual intervention.


## Requirements
- RHEL 8 system
- Permission to register rhel systems
- Root access

## Usage
1. Clone this repository to your RHEL 8 system.
   ```bash
   git clone https://github.com/iagor1/scripts_upgrade_rhel8_to_9.git
   ```

2. Run script
    ```bash
    ./config_pre_upgrade_rhel8.sh | tee output_pre_upgrade.txt
    ```
    After this script system will <b>reboot!</b>
    
    Finaly if you got the same warnings you can upgrade
    ```bash
    ./upgrade_rhel8.sh | tee output_upgrade.txt
    ```
    *You may use nohup to run in backgroud and save the output*
3. Info about others Inhibitors check the file `others_inhibitors.md`

## Extra
If you are having long downtime at reboot you should consider change selinux to permissive mode and exclude dirs with large files.

Link how to avoid downtime : https://access.redhat.com/solutions/7005567
