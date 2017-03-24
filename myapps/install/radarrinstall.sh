#!/bin/bash

apt update && apt install libmono-cil-dev curl mediainfo

sudo adduser --disabled-password --system --home /opt/ProgramData/radarr --gecos "Radarr Service" --group radarr

echo "<--- Downloading latest Radarr --->"
#At the time /v0.2.0.99 is the latest Radarr that is stable
wget https://github.com/Radarr/Radarr/releases/download/v0.2.0.99/Radarr.develop.0.2.0.99.linux.tar.gz
tar -xvzf Radarr.develop.0.2.0.99.linux.tar.gz


#cd /opt && sudo git clone https://github.com/Radarr/Radarr/releases
sudo chown -R radarr:radarr /opt/Radarr/
sudo chmod -R 0777 /opt/Radarr


echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/Services/radarr.service /etc/systemd/system/
chmod 644 /etc/systemd/system/radarr.service
systemctl enable radarr.service
systemctl restart radarr.service 
