#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

adduser --disabled-password --system --home /opt/ProgramData/ubooquity --gecos "Ubooquity Service" --group ubooquity
add-apt-repository -y ppa:webupd8team/java
apt get update

echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
apt install oracle-java8-installer unzip -y
mkdir -p /opt/ubooquity
cd /opt/ubooquity

wget "http://vaemendis.net/ubooquity/service/download.php" -O ubooquity.zip
unzip ubooquity*.zip
rm ubooquity*.zip

chmod 0777 -R /opt/ubooquity
chown -R ubooquity:ubooquity /opt/ubooquity

echo "Creating Startup Script"
cp /opt/install/Ubooquity/ubooquity.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ubooquity.service
systemctl enable ubooquity.service
systemctl restart ubooquity.service
