#!/bin/bash

#install and start puppet server

#rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppetserver

systemctl enable puppetserver

puppet module install theurbanpenguin/puppet_vim
puppet apply -e " include puppet_vim "

puppet module install puppetlabs/stdlib
