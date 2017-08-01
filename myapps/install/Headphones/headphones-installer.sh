#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

adduser --disabled-password --system --home /opt/ProgramData/headphones --gecos "Headphones Service" --group headphones
echo '<--- Downloading latest Headphones --->'
cd /opt &&  git clone https://github.com/rembo10/headphones.git
apt install python git-core -y
echo "<--- Restoring Headphones Settings --->"
#cat /opt/install/Headphones/Headphones.txt > /opt/headphones/config.ini
chown -R headphones:headphones /opt/headphones
chmod -R 0777 /opt/headphones

echo "Creating Startup Script"
cp /opt/install/Headphones/headphones.service /etc/systemd/system/
chmod 644 /etc/systemd/system/headphones.service
systemctl enable headphones.service
systemctl restart headphones.service
