# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'uri'
# Configuration
STORM_DIST_URL = "https://dist.apache.org/repos/dist/release/incubator/storm/apache-storm-0.9.1-incubating/apache-storm-0.9.1-incubating.zip"
STORM_SUPERVISOR_COUNT = 2
STORM_BOX_TYPE = "precise64"
# end Configuration

STORM_ARCHIVE = File.basename(URI.parse(STORM_DIST_URL).path)
STORM_VERSION = File.basename(STORM_ARCHIVE, '.*')

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true
  config.vm.provision :hostmanager
  config.vm.box = STORM_BOX_TYPE

  if(!File.exist?(STORM_ARCHIVE))
    `wget -N #{STORM_DIST_URL}`
  end
  
  config.vm.define "ganglia" do |node|
    ip = "192.168.202.2"
    node.vm.network "private_network", ip: ip
    node.vm.hostname = "ganglia"
    node.vm.provision "shell", path: "install-gmetad.sh"
  end
  
  config.vm.define "zookeeper" do |zookeeper|
    ip = "192.168.202.3"
    zookeeper.vm.network "private_network", ip: ip
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision "shell", path: "install-zookeeper.sh"
    zookeeper.vm.provision "shell", path: "install-gmond.sh", args: ip
    zookeeper.vm.provider "vmware_fusion" do |v|
      v.vmx["memsize"] = "1024"
      #v.vmx["numvcpus"] = "2"
    end
  end

  config.vm.define "nimbus" do |nimbus|
    ip = "192.168.202.4"
    nimbus.vm.network "private_network", ip: ip
    nimbus.vm.hostname = "nimbus"
    nimbus.vm.provision "shell", path: "install-gmond.sh", args: ip
    nimbus.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, "localhost"]
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "nimbus"
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "ui"
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "drpc"
    nimbus.vm.provision "shell", path: "start-supervisord.sh"
    
  end

  (1..STORM_SUPERVISOR_COUNT).each do |n|
    config.vm.define "supervisor#{n}" do |supervisor|
      ip = "192.168.202.#{4 + n}"
      supervisor.vm.network "private_network", ip: ip
      supervisor.vm.hostname = "supervisor#{n}"
      supervisor.vm.provision "shell", path: "install-gmond.sh", args: ip
      supervisor.vm.provision "shell", path: "install-storm.sh", args: [STORM_VERSION, "localhost"]
      supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
      supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
      supervisor.vm.provision "shell", path: "start-supervisord.sh"
      
    end
  end
end
