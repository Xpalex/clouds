#!/bin/sh
cmd=$(egrep '^(NAME)=' /etc/os-release)
deb='NAME="Debian GNU/Linux"'
echo $cmd
if [[ $cmd == $deb ]]; then
   yes Y | sudo sh -c 'echo deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main >> /etc/apt/sources.list'
   yes Y | sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
   yes Y | sudo apt-get update && sudo apt-get i upgrade
   yes Y | sudo apt-get install ansible
   cd /tmp/srv_ansible_data
   ansible-playbook playbook.yml
else [[ $dist == 'fedora' ]] || [[ $(uname -s) == Linux ]];
   yes Y | sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
   yes Y | sudo yum update -y
   yes Y | sudo yum install ansible -y
   cd /tmp/srv_ansible_data
   ansible-playbook playbook.yml
fi
