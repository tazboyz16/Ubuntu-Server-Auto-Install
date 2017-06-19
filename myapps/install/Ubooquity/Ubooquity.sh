#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/ubooquity --gecos "Ubooquity Service" --group ubooquity

echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | sudo tee -a /etc/apt/sources.list.d/webupd8team-java.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
sudo apt-get update
sudo apt-get install oracle-java8-installer unzip -y

sudo mkdir -p /opt/ubooquity
cd /opt/ubooquity

sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O ubooquity.zip
sudo unzip ubooquity*.zip
sudo rm ubooquity*.zip

sudo chmod 0777 -R /opt/ubooquity
sudo chown -R ubooquity:ubooquity /opt/ubooquity


echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/Ubooquity/ubooquity.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ubooquity.service
systemctl enable ubooquity.service
systemctl restart ubooquity.service
