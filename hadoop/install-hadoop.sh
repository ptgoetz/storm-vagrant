#!/bin/sh
echo "127.0.0.1	localhost" > /etc/hosts

apt-get update
apt-get install -y openjdk-6-jdk
tar -zxf /vagrant/hadoop/hadoop-2.2.0.tar.gz

ln -s hadoop-2.2.0 hadoop

cp /vagrant/hadoop/core-site.xml /home/vagrant/hadoop/etc/hadoop/
cp /vagrant/hadoop/hdfs-site.xml /home/vagrant/hadoop/etc/hadoop/
cp /vagrant/hadoop/hadoop-env.sh /home/vagrant/hadoop/etc/hadoop/

chown -R vagrant:vagrant /home/vagrant/hadoop-2.2.0


su - vagrant -c "ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa"
su - vagrant -c "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
# 
# cp /vagrant/hadoop/bashrc /home/vagrant/.bashrc

cat /vagrant/hadoop/environment.txt >> /home/vagrant/.profile