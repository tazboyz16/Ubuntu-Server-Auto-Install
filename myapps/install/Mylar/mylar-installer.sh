#!/bin/bash

echo '<--- Installing prerequisites for Mylar --->'
apt install git-core python python-cheetah python-pyasn1 -y

adduser --disabled-password --system --home /opt/ProgramData/mylar --gecos "Mylar Service" --group mylar

echo '<--- Downloading latest Mylar --->'
cd /opt && sudo git clone https://github.com/evilhero/mylar.git

echo "<--- Restoring Mylar Settings --->"
cat /opt/install/Mylar/Mylar.txt > /opt/mylar/config.ini
chown -R mylar:mylar /opt/mylar
chmod -R 0777 /opt/mylar

echo "Creating Startup Script"
cp /opt/install/Mylar/mylar.service /etc/systemd/system/
chmod 644 /etc/systemd/system/mylar.service
systemctl enable mylar.service
systemctl restart mylar.service
