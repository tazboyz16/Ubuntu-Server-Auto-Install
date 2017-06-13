#!/bin/bash

sudo apt-get -yqq install git-core python python-cheetah python-pyasn1 python3-lxml

sudo adduser --disabled-password --system --home /opt/ProgramData/couchpotato --gecos "CouchPotato Service" --group couchpotato

echo "<--- Downloading latest CouchPotato --->"
cd /opt && sudo git clone https://github.com/CouchPotato/CouchPotatoServer.git
sudo chown -R couchpotato:couchpotato /opt/CouchPotatoServer/
sudo chmod -R 0777 /opt/CouchPotatoServer

echo "<--- Restoring CouchPotato Settings --->"
sudo chmod -R 0777 /opt/ProgramData/

#changing lines to edit SSL settings to accept the SSL Created in Certbot
#line 5 and 7 for
#ssl_key = and ssl_cert =
sed -i "s/ssl_key = .*/ssl_key = /etc/apache2/ssl/apache.key" /opt/ProgramData/couchpotato/.couchpotato/settings.conf
sed -i "s/ssl_cert = .*/ssl_cert = /etc/apache2/ssl/apache.crt/" /opt/ProgramData/couchpotato/.couchpotato/settings.conf

#uncomment this line and comment out the sed lines if you have Couchpotato settings config saved
#cp /home/xxxsernamexxx/install/CouchPotato/CouchPotato.txt /opt/ProgramData/couchpotato/.couchpotato/settings.conf

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/CouchPotato/couchpotato.service /etc/systemd/system/
chmod 644 /etc/systemd/system/couchpotato.service
systemctl enable couchpotato.service
systemctl restart couchpotato.service 
