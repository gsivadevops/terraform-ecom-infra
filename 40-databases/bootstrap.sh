#!/bin/bash

component=$1
dnf install ansible -y
# Pulling the Ansible code
#ansible-pull -U https://github.com/gsivadevops/ansible-ecommerce-roles.git -e component=$1 -e MYSQL_ROOT_PASSWORD=$2 main.yaml
ansible-pull -U https://github.com/gsivadevops/ansible-ecommerce-roles.git -e component=$1 main.yaml

