#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/Organizer --gecos "Organizr Service" --group Organizr

sudo bash /opt/install/Apache2/Apache2-install.sh

sudo apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
apt-get remove php7.0-snmp -yy

cd /opt && git clone https://github.com/causefx/Organizr.git

sudo chown -R Organizr:Organizr /opt/Organizr
sudo chmod -R 0777 /opt/Organizr

sudo cp /opt/install/Organizr/Organizr.conf /etc/apache2/sites-available/

sudo a2ensite Organizr.conf
sudo service apache2 restart
