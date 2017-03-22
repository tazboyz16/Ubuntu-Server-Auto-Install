#!/bin/bash

echo "SickRage Update"
sudo systemctl stop sickrage
sleep 5
cd /opt/sickrage
git pull
sudo systemctl start sickrage
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

echo "CouchPotato Update"
sudo systemctl stop Couchpotato
sleep 5
cd /opt/couchpotato
git pull
sudo systemctl start Couchpotato
echo

echo "Grive Website backup"
#have to setup Grive for it leaves a config after setup on dir location
cd /var/www
sudo grive 
echo

echo "Plex Server Update"
sudo bash /home/xxxusernamexxx/update/plexupdate.sh -p -a -d -u
echo

echo "Running System Security Updates"
unattended-upgrades -v
