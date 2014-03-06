apt-get update
apt-get install --yes ganglia-monitor
cp /vagrant/slave-gmond.conf /etc/ganglia/gmond.conf
#sed -i "s/\${host}/$1/g" /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart
