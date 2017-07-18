#!/bin/bash

sudo adduser --disabled-password --system --home /opt/ProgramData/ubooquity --gecos "Ubooquity Service" --group ubooquity

sudo add-apt-repository -y ppa:webupd8team/java
sudo apt-get update

echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt install oracle-java8-installer unzip -y

sudo mkdir -p /opt/ubooquity
cd /opt/ubooquity

sudo wget "http://vaemendis.net/ubooquity/service/download.php" -O ubooquity.zip
sudo unzip ubooquity*.zip
sudo rm ubooquity*.zip

sudo chmod 0777 -R /opt/ubooquity
sudo chown -R ubooquity:ubooquity /opt/ubooquity


echo "Creating Startup Script"
cp /opt/install/Ubooquity/ubooquity.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ubooquity.service
systemctl enable ubooquity.service
systemctl restart ubooquity.service
