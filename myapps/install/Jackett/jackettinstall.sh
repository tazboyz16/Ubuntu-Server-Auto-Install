#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/jackett --gecos "Jackett Service" --group jackett

cd
sudo wget $(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep 'Jackett.Binaries.Mono.tar.gz' | cut -d\" -f4)
sudo tar -xvf Jackett.Binaries.Mono.tar.gz && sudo rm Jackett.Binaries.Mono.tar.gz
sudo mkdir /opt/Jackett
sudo mv Jackett/* /opt/Jackett
sudo rm -r Jackett
sudo chmod 0777 -R /opt/Jackett
sudo chown -R jackett:jackett /opt/Jackett


echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/Jackett/jackett.service /etc/systemd/system/
chmod 644 /etc/systemd/system/jackett.service
systemctl enable jackett.service
systemctl restart jackett.service
