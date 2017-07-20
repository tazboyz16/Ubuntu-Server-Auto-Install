#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/Muximux --gecos "Muximux Service" --group Muximux

sudo bash /opt/install/Apache2/Apache2-install.sh

sudo apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
apt-get remove php7.0-snmp -yy

cd /opt && git clone https://github.com/mescon/Muximux.git

sudo chown -R Muximux:Muximux /opt/Muximux
sudo chmod -R 0777 /opt/Muximux

sudo cp /opt/install/Muximux/Muximux.conf /etc/apache2/sites-available/

sudo a2ensite Muximux.conf
sudo service apache2 restart
