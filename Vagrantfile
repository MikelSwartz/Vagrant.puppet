# -*- mode: ruby -*-
# vi: set ft=ruby :
#Run this bash command below to setup the private network on VBox
# VBoxManage natnetwork add --netname CDHNatNetwork --network 10.0.15.0/24 --enable --dhcp on

Vagrant.configure("2") do |config|
  
config.vm.define  "ppm01" do |ppm01|
    config.vm.provider "virtualbox" do |vb|
      vb.name = "ppm01"
      vb.memory = "2048"
      vb.cpus = 1
    end
    ppm01.vm.box = "centos/7"
    ppm01.vm.hostname = "ppm01.master"
    ppm01.vm.network "private_network", ip: "10.0.15.100"
    ppm01.vm.synced_folder ".", "/vagrant"
    ppm01.vm.provision "shell", path: "provision.sh"
    ppm01.vm.provision "shell", path: "puppet.server.pr.sh"
    ppm01.vm.provision "shell", path: "reboot.pr.sh"
  end

  config.vm.define  "db01" do |db01|
    config.vm.provider "virtualbox" do |vb|
      vb.name = "db01"
      vb.memory = "1024"
    end
    db01.vm.box = "centos/7" 	#RedHat 7 here. 
    db01.vm.hostname = "db01.node"
    db01.vm.network "private_network", ip: "10.0.15.110"
    db01.vm.synced_folder ".", "/vagrant"
    db01.vm.provision "shell", path: "provision.sh"
    db01.vm.provision "shell", path: "puppet.agent.pr.sh"
    db01.vm.provision "shell", path: "reboot.pr.sh"
  end

  config.vm.define  "web01" do |web01|
    config.vm.provider "virtualbox" do |vb|
      vb.name = "web01"
      vb.memory = "1024"
    end
    web01.vm.box = "centos/7"
    web01.vm.hostname = "web01.node"
    web01.vm.network "private_network", ip: "10.0.15.120"
    web01.vm.synced_folder ".", "/vagrant"
    web01.vm.provision "shell", path: "provision.sh"
    web01.vm.provision "shell", path: "puppet.agent.pr.sh"
    web01.vm.provision "shell", path: "reboot.pr.sh"
  end

end
