#!/bin/bash

## get packages required to build deluge ##
echo "<--- Adding Deluge Team Dep Packages--->"
sudo add-apt-repository -y ppa:deluge-team/ppa
apt-get update -qq

## setup deluge user
echo "<--- Now we will setup a user for Deluge --->"
sudo adduser --disabled-password --system --home /var/lib/deluge --gecos "Deluge service" --group deluge

sudo touch /var/log/deluged.log
sudo touch /var/log/deluge-web.log
sudo chown deluge:deluge /var/log/deluge*

sudo apt-get update -qq && sudo apt-get install -yqq deluged deluge-webui

echo "Creating New Startup Script"
cp /home/xxxusernamexxx/install/Services/deluged.service /etc/systemd/system/
cp /home/xxxusernamexxx/install/Services/deluge-web.service /etc/systemd/system/
chmod 644 /etc/systemd/system/deluged.service
chmod 644 /etc/systemd/system/deluge-web.service
systemctl enable deluged.service
systemctl enable deluge-web.service
systemctl start deluged
systemctl start deluge-web
sleep 15

echo "<--Restoring Deluge Settings and Switch to Systemctl startup scripts-->"
#defaults settings stored at /var/lib/deluge/.config/deluge
#core.conf and web.conf
systemctl stop deluged
systemctl stop deluge-web
sleep 15
sudo chmod 0777 -R /var/lib/deluge/
cp /home/xxxusernamexxx/install/configs/deluge/core.conf /var/lib/deluge/.config/deluge
cp /home/xxxusernamexxx/install/configs/deluge/web.conf /var/lib/deluge/.config/deluge
systemctl start deluged
systemctl start deluge-web
