# Storm Security Vagrant setup

This project contains vagrant and additional configs to run storm security cluster.
It will spin up 4 vms with kerberos and storm cluster running.

### requirements
+ Vagrant 
+ Virtual box
+ wget 

### Install
+ git clone git@github.com:harshach/storm-vagrant.git; git checkout -b security origin/security
+ vagrant up

### SSH
+ vagrant ssh hostname (nimbus,zookeeper, supervisor1 etcc..)

### VM Hosts
+ zookeeper (zookeeper.withend.com, kdc.witzend.com)  
	This host runs both zookeeper and kerberos. 
+ nimbus ( nimbus.witzend.com )  
	This host runs nimbus , ui, drpc-server. 
	To start or stop services run sudo supervisorctl.
+ supervisor1( supervisor1.witzend.com )  
    This host runs supervisor dameon. use supervisorctl to start/stop.
+ supervisor2 (supervisor2.witzend.com)  
	 This host runs supervisor daemon. use supervisorctl to start/stop.

### Kerberos Keytabs
+ all the keytabs generated during the install are stored /vagrant/keytabs(storm-vagrant/keytabs)
+ nimbus runs with /vagrant/storm_jaas.conf
+ There are testuser1, testuser2 users created for submitting topologies
+ To submit a topology  
	+ vagrant ssh nimbus
	+ sudo su testuser1
	+ storm jar topology

### Storm UI
+ Storm UI is configured to run with hadoop-auth authentication filter
+ To access storm UI from your host
+ copy storm-vagrant/kerberos/krb5.conf /etc/krb5.conf
+ Add nimbus ip to your /etc/hosts . In this case it would be  
   192.168.202.4 nimbus.witzend.com
+ Open firefox goto about:config 
  search for network.negotiate-auth.allow-proxies and set it true  
  network.negotiate-auth.allow-non-fqdn set it true  
  network.negotiate-auth.trusted-uris set it to http://nimbus.witzend.com:8080 
+ run kinit -k -t storm-vagrant/keytabs/testuser1.keytab testuser1/nimbus.witzend.com
+ you'll be logged into nimbus as testuser1