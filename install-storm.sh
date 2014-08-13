echo "127.0.0.1	localhost" > /etc/hosts
echo "127.0.1.1	$3 $4" >> /etc/hosts
cp /vagrant/krb5.conf /etc/

cp /vagrant/resolvconf_base.txt /etc/resolvconf/resolv.conf.d/base
cp /vagrant/dhclient.conf /etc/dhcp/
resolvconf -u
/etc/init.d/networking restart

apt-get install -y supervisor unzip openjdk-7-jdk krb5-user

/etc/init.d/supervisor stop

groupadd storm
useradd --gid storm --home-dir /home/storm --create-home --shell /bin/bash storm
useradd --gid storm --home-dir /home/harsha --create-home --shell /bin/bash harsha

unzip -o /vagrant/$1.zip -d /usr/share/
chown -R storm:storm /usr/share/$1
ln -s /usr/share/$1 /usr/share/storm
ln -s /usr/share/storm/bin/storm /usr/bin/storm

mkdir /etc/storm
chown storm:storm /etc/storm

rm /usr/share/storm/conf/storm.yaml
cp /vagrant/storm.yaml /usr/share/storm/conf/
cp /vagrant/cluster.xml /usr/share/storm/logback/
ln -s /usr/share/storm/conf/storm.yaml /etc/storm/storm.yaml

mkdir /var/log/storm
chown storm:storm /var/log/storm

sed -i "s/\${host}/$2/g" /usr/share/storm/conf/storm.yaml

#sed -i 's/${storm.home}\/logs/\/var\/log\/storm/g' /usr/share/storm/logback/cluster.xml
