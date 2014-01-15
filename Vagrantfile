# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'uri'

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
STORM_DIST_URL = "https://dl.dropboxusercontent.com/s/dj86w8ojecgsam7/storm-0.9.0.1.zip"
STORM_ARCHIVE = File.basename(URI.parse(STORM_DIST_URL).path)
STORM_VERSION = File.basename(STORM_ARCHIVE, '.*')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.hostmanager.manage_host = true
  config.hostmanager.enabled = true
  config.vm.box = "precise32"

  
  if(!File.exist?(STORM_ARCHIVE))
    `wget -N #{STORM_DIST_URL}`
  end
  
  config.vm.define "zookeeper" do |zookeeper|
    zookeeper.vm.network "private_network", ip: "192.168.50.3"
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision "shell", path: "install-zookeeper.sh"
  end

  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.network "private_network", ip: "192.168.50.4"
    nimbus.vm.hostname = "nimbus"
    
    nimbus.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "nimbus"
    
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "ui"
    
    nimbus.vm.provision "shell", path: "config-supervisord.sh", args: "drpc"
    
    nimbus.vm.provision "shell", path: "start-supervisord.sh"
  end

  config.vm.define "supervisor1" do |supervisor|
    supervisor.vm.network "private_network", ip: "192.168.50.5"
    supervisor.vm.hostname = "supervisor1"
    
    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
    
  end
  
  config.vm.define "supervisor2" do |supervisor|
    supervisor.vm.network "private_network", ip: "192.168.50.6"
    supervisor.vm.hostname = "supervisor2"
    
    supervisor.vm.provision "shell", path: "install-storm.sh", args: STORM_VERSION
    
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "supervisor"
    
    supervisor.vm.provision "shell", path: "config-supervisord.sh", args: "logviewer"
    
    supervisor.vm.provision "shell", path: "start-supervisord.sh"
    
  end
  
end
