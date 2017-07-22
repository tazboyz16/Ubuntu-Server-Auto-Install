#!/bin/bash

echo "SickRage Update"
sudo systemctl stop sickrage
sleep 5
cd /opt/SickRage
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

echo "CouchPotato Update"
sudo systemctl stop Couchpotato
sleep 5
cd /opt/CouchPotatoServer
git fetch --all
git reset --hard origin/master
git pull
sudo systemctl start Couchpotato

