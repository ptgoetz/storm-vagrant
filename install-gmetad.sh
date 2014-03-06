apt-get install --yes ganglia-monitor ganglia-webfrontend gmetad rrdtool 

cp /vagrant/master-gmond.conf /etc/ganglia/gmond.conf
#sed -i "s/\${host}/$1/g" /etc/ganglia/gmond.conf
/etc/init.d/ganglia-monitor restart

cp /vagrant/gmetad.conf /etc/ganglia/
/etc/init.d/gmetad restart

cp /etc/ganglia-webfrontend/apache.conf /etc/apache2/sites-enabled/
/etc/init.d/apache2 restart