#!/bin/bash

versionm=$(lsb_release -cs)



apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
apt update 
apt install libmono-cil-dev curl mediainfo mono-devel -y
adduser --disabled-password --system --home /opt/ProgramData/radarr --gecos "Radarr Service" --group radarr
echo "<--- Downloading latest Radarr --->"
cd /opt && wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.778/Radarr.develop.0.2.0.778.linux.tar.gz
tar -xvzf Radarr.develop.0.2.0.778.linux.tar.gz
rm -rf Radarr.develop.0.2.0.778.linux.tar.gz
chown -R radarr:radarr /opt/Radarr/
chmod -R 0777 /opt/Radarr
echo "Creating Startup Script"
cp /opt/install/Radarr/radarr.service /etc/systemd/system/
chmod 644 /etc/systemd/system/radarr.service
systemctl enable radarr.service
systemctl restart radarr.service
