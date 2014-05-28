# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'uri'
# Configuration
STORM_DIST_URL = "https://dist.apache.org/repos/dist/release/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.2-incubating-SNAPSHOT.zip"
STORM_SUPERVISOR_COUNT = 2
STORM_BOX_TYPE = "precise64"
# end Configuration

STORM_ARCHIVE = File.basename(URI.parse(STORM_DIST_URL).path)
STORM_VERSION = File.basename(STORM_ARCHIVE, '.*')

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  #config.hostmanager.manage_host = true
  #config.hostmanager.enabled = true
  #config.vm.provision :hostmanager
  config.vm.box = STORM_BOX_TYPE

  if(!File.exist?(STORM_ARCHIVE))
    `wget -N #{STORM_DIST_URL}`
  end
  
  config.vm.define "zookeeper" do |node|
    ip = "192.168.202.3"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "zookeeper"
    node.vm.provision "shell", inline: "apt-get update"
    node.vm.provision "shell", path: "bind/install-bind.sh"
    node.vm.provision "shell", path: "kerberos/install-kdc.sh"
    node.vm.provision "shell", path: "zookeeper/install-zookeeper.sh"
    
    node.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "1024"
      #v.vmx["numvcpus"] = "2"
    end
  end

  config.vm.define "nimbus" do |node|
    ip = "192.168.202.4"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "nimbus"
    node.vm.provision "shell", inline: "apt-get update"
    node.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, "localhost"]
    node.vm.provision "shell", path: "config-supervisord.sh", args: "nimbus"
    node.vm.provision "shell", path: "config-supervisord.sh", args: "ui"
    node.vm.provision "shell", path: "config-supervisord.sh", args: "drpc"
    #node.vm.provision "shell", path: "start-supervisord.sh"
    
  end

  (1..STORM_SUPERVISOR_COUNT).each do |n|
    config.vm.define "supervisor#{n}" do |node|
      ip = "192.168.202.#{4 + n}"
      node.vm.network "private_network", ip: ip
      node.vm.hostname = "supervisor#{n}"
      node.vm.provision "shell", inline: "apt-get update"
      node.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, "localhost"]
      node.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
      node.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
      node.vm.provision "shell", path: "start-supervisord.sh"
      
    end
  end
  
  # single-node pseudo cluster
  config.vm.define "hadoop" do |node|
    ip = "192.168.202.10"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "hadoop"
    node.vm.provision "shell", path: "hadoop/install-hadoop.sh"
  end
  
  config.vm.define "kerberos" do |node|
    ip = "192.168.202.11"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "kerberos"
    node.vm.provision "shell", path: "kerberos/install-kdc.sh"
  end
  
end
