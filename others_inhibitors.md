
This file contains commands to fix others inhibitors, if you need just edit the script :)

Risk Factor: high (inhibitor)
Title: Possible problems with remote login using root account
```bash
echo 'Fixing : Possible problems with remote login using root account '
sed -i '/PermitRootLogin yes/s/^/#/' /etc/ssh/sshd_config
systemctl restart sshd
```

Risk Factor: medium (inhibitor)
Title: A YUM/DNF repository defined multiple times
Summary: The following repositories are defined multiple times:
The hint will indicate which repositories you must fix (delete)
Go to `/etc/yum.repos.d/` and remove the repo 
