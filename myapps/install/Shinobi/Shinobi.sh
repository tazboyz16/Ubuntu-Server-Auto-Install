#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/Shinobi --gecos "Shinobi Service" --group Shinobi

cd /opt &&  git clone https://github.com/moeiscool/Shinobi.git

sudo chown -R Shinobi:Shinobi /opt/Shinobi
sudo chmod -R 0777 /opt/Shinobi

sudo bash /opt/Shinobi/INSTALL/ubuntu.sh

cd /opt/Shinobi
cp conf.sample.json conf.json
#edit conf.json with correct timezone and with correct mysql login
#to start pm2 start camera.js

cd
echo "Creating Startup Script" 
cp /home/xxxusernamexxx/install/Shinobi/Shinobi.service /etc/systemd/system/
chmod 644 /etc/systemd/system/Shinobi.service
systemctl enable Shinobi.service
systemctl restart Shinobi.service
