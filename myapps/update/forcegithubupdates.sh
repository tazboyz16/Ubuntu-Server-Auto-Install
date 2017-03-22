#!/bin/bash

echo "SickRage Auto Update"
sudo systemctl stop sickrage
sleep 5
cd /opt/sickrage
git fetch --all
git reset --hard origin/master
git pull
sudo systemctl start sickrage
echo

echo "Mylar Update"
sudo systemctl stop Mylar
sleep 5
cd /opt/mylar
git fetch --all
git reset --hard origin/master
git pull
sudo systemctl start Mylar
echo

echo "Headphones Update"
sudo systemctl stop Headphones
sleep 5
cd /opt/headphones
git fetch --all
git reset --hard origin/master
git pull
sudo systemctl start Headphones
echo

echo "CouchPotato Auto Update"
sudo systemctl stop Couchpotato
sleep 5
cd /opt/couchpotato
git fetch --all
git reset --hard origin/master
git pull
sudo systemctl start Couchpotato

