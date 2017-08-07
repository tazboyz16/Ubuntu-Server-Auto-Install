#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "Installing PlexPy"
adduser --disabled-password --system --no-create-home --gecos "PlexPy Service"  --group plexpy
cd /opt && git clone https://github.com/JonnyWong16/plexpy.git
#echo "<--- Restoring PLexPy Settings --->"
#cat /opt/install/PlexAddons/Headphones.txt > /opt/.headphones/config.ini
chown -R plexpy:plexpy /opt/plexpy
chmod -R 0777 /opt/plexpy
echo "Creating Startup Script for PlexPy"
cp /opt/install/Plex/plexpy.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/plexpy.service
systemctl enable plexpy.service
systemctl restart plexpy.service
