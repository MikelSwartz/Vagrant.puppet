#!/bin/bash

#Install some tools
yum -y install vim git ntp net-tools 

#Setup ntp for puppet. CentOS uses chronyd which conflicts with ntpd
systemctl stop chronyd.service
systemctl disable chronyd.service
ntpdate pool.ntp.org
systemctl enable ntpd.service

#Configure SELinux
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/sysconfig/selinux
sed -i 's/^SELINUX=.*/SELINUX=permissive/g' /etc/selinux/config

#Setup hosts for no DNS
echo 127.0.0.1   localhost.localhost localhost > /etc/hosts
echo 10.0.15.100 ppm01.master	ppm01 >> /etc/hosts
echo 10.0.15.110 db01.node	db01 >> /etc/hosts
echo 10.0.15.120 web01.node	web01 >> /etc/hosts

#Disable root ssh login 
sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
#Add puppet to secure path in sudoers
sed -i '/^Defaults    secure_path/ s/$/:\/opt\/puppetlabs\/bin/' /etc/sudoers

systemctl start firewalld.service
sleep 10
firewall-cmd --permanent --zone=public --add-interface=eth1
firewall-cmd --zone=public --permanent --add-port=8140/tcp
systemctl enable firewalld.service

#Generate key
ssh-keygen -f $HOME/.ssh/id_rsa -t rsa -N ''
