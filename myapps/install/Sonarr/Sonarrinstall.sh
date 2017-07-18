#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/sonarr --gecos "Sonarr Service" --group sonarr

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
echo "deb http://apt.sonarr.tv/ master main" | sudo tee /etc/apt/sources.list.d/sonarr.list

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-offical.list

sudo apt-get update && sudo apt install nzbdrone libmono-cil-dev apt-transport-https mono-devel -y

sudo chown -R sonarr:sonarr /opt/NzbDrone

#echo "<--- Restoring sonarr Settings --->"
#cat /opt/install/Sonarr/CouchPotato.txt > /opt/CouchPotatoServer/settings.conf

echo "Creating Startup Script"
cp /opt/install/Sonarr/sonarr.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sonarr.service
systemctl enable sonarr.service
systemctl restart sonarr.service
