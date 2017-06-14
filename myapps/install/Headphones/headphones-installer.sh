#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/headphones --gecos "Headphones Service" --group headphones

echo '<--- Downloading latest Headphones --->'
cd /opt &&  git clone https://github.com/rembo10/headphones.git

#echo "<--- Restoring Headphones Settings --->"
#cat /home/xxxusernamexxx/install/Headphones/Headphones.txt > /opt/headphones/config.ini

sudo chown -R headphones:headphones /opt/headphones
sudo chmod -R 0777 /opt/headphones

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/Headphones/headphones.service /etc/systemd/system/
chmod 644 /etc/systemd/system/headphones.service
systemctl enable headphones.service
systemctl restart headphones.service
