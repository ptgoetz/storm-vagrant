cp /vagrant/kerberos/krb5.conf /etc/

cp /vagrant/dhclient.conf /etc/dhcp/
cp /vagrant/resolvconf_base.txt /etc/resolvconf/resolv.conf.d/base
resolvconf -u
/etc/init.d/networking restart

groupadd zookeeper
useradd --gid zookeeper --home-dir /home/zookeeper --create-home --shell /bin/bash zookeeper

apt-get --yes install openjdk-7-jdk krb5-user

wget -q http://www.us.apache.org/dist/zookeeper/zookeeper-3.4.5/zookeeper-3.4.5.tar.gz

tar -zxf zookeeper-3.4.5.tar.gz -C /usr/share

ln -s /usr/share/zookeeper-3.4.5 /usr/share/zookeeper

cp /vagrant/zookeeper/zookeeper.conf /etc/init/

cp /vagrant/zookeeper/java.env /usr/share/zookeeper/conf/
cp /vagrant/zookeeper/zoo.cfg /usr/share/zookeeper/conf/
cp /vagrant/zookeeper/jaas.conf /usr/share/zookeeper/conf/

chown -R zookeeper:zookeeper /usr/share/zookeeper-3.4.5

start zookeeper
