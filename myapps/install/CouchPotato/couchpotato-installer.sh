#!/bin/bash

sudo apt-get -yqq install git-core python python-cheetah python-pyasn1 python3-lxml

sudo adduser --disabled-password --system --home /opt/ProgramData/couchpotato --gecos "CouchPotato Service" --group couchpotato

echo "<--- Downloading latest CouchPotato --->"
cd /opt && sudo git clone https://github.com/CouchPotato/CouchPotatoServer.git
sudo chown -R couchpotato:couchpotato /opt/CouchPotatoServer/
sudo chmod -R 0777 /opt/CouchPotatoServer

echo "<--- Restoring CouchPotato Settings --->"
sudo chmod -R 0777 /opt/ProgramData/

#changing this line to edit SSL settings to accept the SSL Created in Certbot
#line 5 and 7 for
#ssl_key =
#ssl_cert =
#cp /home/xxxsernamexxx/install/CouchPotato/CouchPotato.txt /opt/ProgramData/couchpotato/.couchpotato/settings.conf

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/CouchPotato/couchpotato.service /etc/systemd/system/
chmod 644 /etc/systemd/system/couchpotato.service
systemctl enable couchpotato.service
systemctl restart couchpotato.service 
