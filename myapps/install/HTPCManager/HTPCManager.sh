#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

sudo apt install libjpeg-dev libpng12-dev libfreetype6-dev zlib1g-dev libc6-dev libc-dev libjpeg8-dev python -y

sudo adduser --disabled-password --system --home /opt/ProgramData/HTPC-Manager --gecos "HTPC-Manager Service" --group HTPCManager

cd /opt &&  git clone https://github.com/styxit/HTPC-Manager.git

sudo chown -R HTPCManager:HTPCManager /opt/HTPC-Manager
sudo chmod -R 0777 /opt/HTPC-Manager

echo "Creating Startup Script"
cp /opt/install/HTPCManager/HTPCManager.service /etc/systemd/system/
chmod 644 /etc/systemd/system/HTPCManager.service
systemctl enable HTPCManager.service
systemctl restart HTPCManager.service
