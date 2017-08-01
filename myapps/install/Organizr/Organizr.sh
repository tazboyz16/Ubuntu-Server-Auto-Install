#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

adduser --disabled-password --system --home /opt/ProgramData/Organizer --gecos "Organizr Service" --group Organizr
bash /opt/install/Apache2/Apache2-install.sh
apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
apt get remove php7.0-snmp -y

cd /opt && git clone https://github.com/causefx/Organizr.git
chown -R Organizr:Organizr /opt/Organizr
chmod -R 0777 /opt/Organizr

cp /opt/install/Organizr/Organizr.conf /etc/apache2/sites-available/
a2ensite Organizr.conf
service apache2 restart
