#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/Organizer --gecos "Organizr Service" --group Organizr

cd /opt && git clone https://github.com/causefx/Organizr.git

sudo chown -R Organizr:Organizr /opt/Organizr
sudo chmod -R 0777 /opt/Organizr


echo "Creating Startup Script" 
cp /home/xxxusernamexxx/install/Organizr/Organizr.service /etc/systemd/system/
chmod 644 /etc/systemd/system/Organizr.service
systemctl enable Organizr.service
systemctl restart Organizr.service
