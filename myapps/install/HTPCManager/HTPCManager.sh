#!/bin/bash

sudo apt-get install libjpeg-dev libpng12-dev libfreetype6-dev zlib1g-dev
#sudo apt-get install python-pip
#sudo pip install PIL

sudo adduser --disabled-password --system --home /opt/ProgramData/HTPC-Manager --gecos "HTPC-Manager Service" --group HTPCManager

cd /opt &&  git clone https://github.com/styxit/HTPC-Manager.git

sudo chown -R HTPCManager:HTPCManager /opt/HTPC-Manager
sudo chmod -R 0777 /opt/HTPC-Manager

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/HTPCManager/HTPCManager.service /etc/systemd/system/
chmod 644 /etc/systemd/system/HTPCManager.service
systemctl enable HTPCManager.service
systemctl restart HTPCManager.service
