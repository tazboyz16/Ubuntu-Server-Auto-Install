#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo '<--- Installing prerequisites for SickRage --->'
apt install git-core unrar-free openssl libssl-dev python2.7 -y
adduser --disabled-password --system --home /opt/ProgramData/sickrage --gecos "Sickrage Service" --group sickrage
echo '<--- Downloading latest SickRage --->'
cd /opt && git clone https://github.com/SickRage/SickRage.git 

echo "<--- Restoring SickRage Settings --->"
#backup files are in sickrage install location for items Cache Folder, failed.db,sickbeard.db, and cache.db
cd
tar xjf /opt/install/SickRage/sickrage.tar.bz2 -C /opt
cp -rf /opt/sickrage/* /opt/SickRage
rm -rf /opt/sickrage

chown -R sickrage:sickrage /opt/SickRage
chmod -R 0777 /opt/SickRage

echo "Creating Startup Script"
cp /opt/install/SickRage/sickrage.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sickrage.service
systemctl enable sickrage.service
systemctl restart sickrage.service
