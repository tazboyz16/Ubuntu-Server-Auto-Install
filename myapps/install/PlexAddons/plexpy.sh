#!/bin/bash

echo "Installing PlexPy"
sudo adduser --disabled-password --system --no-create-home --gecos "PlexPy Service"  --group plexpy

cd /opt && sudo git clone https://github.com/JonnyWong16/plexpy.git

#echo "<--- Restoring PLexPy Settings --->"
#cat /home/xxxusernamexxx/install/PlexAddons/Headphones.txt > /home/xxxusernamexxx/.headphones/config.ini

sudo chown -R plexpy:plexpy /opt/plexpy
sudo chmod -R 0777 /opt/plexpy

echo "Creating Startup Script for PlexPy"
cp /home/xxxusernamexxx/install/PlexAddons/plexpy.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/plexpy.service
systemctl enable plexpy.service
systemctl restart plexpy.service
