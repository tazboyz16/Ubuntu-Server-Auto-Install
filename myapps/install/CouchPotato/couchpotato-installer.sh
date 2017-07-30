#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

sudo apt install git-core python python-cheetah python-pyasn1 python3-lxml -y

sudo adduser --disabled-password --system --home /opt/ProgramData/couchpotato --gecos "CouchPotato Service" --group couchpotato

echo "<--- Downloading latest CouchPotato --->"
cd /opt && sudo git clone https://github.com/CouchPotato/CouchPotatoServer.git
sudo chown -R couchpotato:couchpotato /opt/CouchPotatoServer/
sudo chmod -R 0777 /opt/CouchPotatoServer

echo "<--- Restoring CouchPotato Settings --->"
sudo chmod -R 0777 /opt/ProgramData/couchpotato
#cp /opt/install/CouchPotato/CouchPotato.txt /opt/ProgramData/couchpotato/.couchpotato/settings.conf

echo "Creating Startup Script"
cp /opt/install/CouchPotato/couchpotato.service /etc/systemd/system/
chmod 644 /etc/systemd/system/couchpotato.service
systemctl enable couchpotato.service
systemctl restart couchpotato.service 
