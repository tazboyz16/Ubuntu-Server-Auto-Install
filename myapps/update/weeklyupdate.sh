#!/bin/bash

echo "SickRage Auto Update"
sudo bash /opt/install/Sickrage/sickrageinstaller.sh -u
echo

echo "Mylar Update"
sudo systemctl stop Mylar
sleep 5
cd /opt/mylar
git pull
sudo systemctl start Mylar
echo

echo "Headphones Update"
sudo systemctl stop Headphones
sleep 5
cd /opt/headphones
git pull
sudo systemctl start Headphones
echo

echo "CouchPotato Auto Update"
sudo systemctl stop Couchpotato
sleep 5
cd /opt/CouchPotatoServer
git pull
sudo systemctl start Couchpotato
echo

echo "Grive Website backup" 
cd /var/www
sudo grive 

echo "Plex Server Update"
sudo bash /opt/update/plexupdate.sh -p -a -d 
echo

echo "Running System Security Updates"
unattended-upgrades -v
