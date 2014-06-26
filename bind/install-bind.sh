sudo apt-get install --yes bind9

cp /vagrant/bind/witzend.com.db /etc/bind/witzend.com.db
cp /vagrant/bind/rev.202.168.192.in-addr.arpa /etc/bind/rev.202.168.192.in-addr.arpa
cp /vagrant/bind/named.conf.local /etc/bind/named.conf.local
cp /vagrant/bind/named.conf.options /etc/bind/named.conf.options

cp /vagrant/bind/sysctl.conf /etc/sysctl.conf
sysctl -p

/etc/init.d/bind9 restart
