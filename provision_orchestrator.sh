#!/bin/bash
# $1 : private key to access instances
# $2 : user 

terraform output -state=terraform/terraform.tfstate output | python gen_inventory.py
ip=$(terraform output -state=terraform/terraform.tfstate orchestrator)
ssh -i $1 $2@$ip 'mkdir -p orchestration/ansible'
scp -i $1 $1 $2@$ip:~/orchestration/key.pem
scp -i $1 ansible/* $2@$ip:~/orchestration/ansible

ssh -i $1 $2@$ip 'sudo sed -i "s/localhost$/localhost orchestrator/" /etc/hosts'
ssh -i $1 $2@$ip 'sudo apt-get update'
ssh -i $1 $2@$ip 'sudo apt-get install -y build-essential python-dev python-pip'
ssh -i $1 $2@$ip 'sudo pip install -U markupsafe ansible'
ssh -i $1 $2@$ip 'sudo ansible-galaxy install aalda.gocd --force'
ssh -i $1 $2@$ip 'sudo ansible-galaxy install voytek.gocd_agent --force'
ssh -i $1 $2@$ip "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ~/orchestration/ansible/inventory ~/orchestration/ansible/provision_continuous_delivery.yml --private-key=~/orchestration/key.pem"
