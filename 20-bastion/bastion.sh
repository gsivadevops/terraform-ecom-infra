# user data to install terraform and increse memory space (Resize EBS Storage)

#!/bin/bash

# terraform installation
yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum -y install terraform

# Resize EBS Storage
growpart /dev/nvme0n1 4
lvextend -L +20G /dev/RootVG/rootVol
lvextend -L +10G /dev/RootVG/homeVol

xfs_growfs /
xfs_growfs /home