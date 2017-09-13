#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "Installing PlexPy"
apt update
apt install python -y
adduser --disabled-password --system --home /opt/ProgramData/PlexPy --gecos "PlexPy Service"  --group plexpy
cd /opt && git clone https://github.com/JonnyWong16/plexpy.git /opt/Plexpy
#echo "<--- Restoring PLexPy Settings --->"
#cat /opt/install/PlexAddons/Headphones.txt > /opt/.headphones/config.ini
chown -R plexpy:plexpy /opt/Plexpy
chmod -R 0777 /opt/Plexpy
echo "Creating Startup Script for PlexPy"
cp /opt/install/Plex/plexpy.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/plexpy.service
systemctl enable plexpy.service
systemctl restart plexpy.service
