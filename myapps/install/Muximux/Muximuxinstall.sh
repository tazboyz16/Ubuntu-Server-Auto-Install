#!/bin/bash

echo "Checking if Script is Running as Root"
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

adduser --disabled-password --system --home /opt/ProgramData/Muximux --gecos "Muximux Service" --group Muximux

bash /opt/install/Apache2/Apache2-install.sh
apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
apt get remove php7.0-snmp -yy

cd /opt && git clone https://github.com/mescon/Muximux.git
chown -R Muximux:Muximux /opt/Muximux
chmod -R 0777 /opt/Muximux
cp /opt/install/Muximux/Muximux.conf /etc/apache2/sites-available/
a2ensite Muximux.conf
service apache2 restart
