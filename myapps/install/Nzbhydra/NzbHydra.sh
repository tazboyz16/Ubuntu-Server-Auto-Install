#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi


adduser --disabled-password --system --home /opt/ProgramData/Nzbhydra --gecos "Ubooquity Service" --group Nzbhydra
apt update; apt install python2.7 git-core -y
apt update; apt upgrade -y
git clone https://github.com/theotherp/nzbhydra /opt/Nzbhydra
sudo chown -R Nzbhydra:Nzbhydra /opt/Nzbhydra

echo "Creating Startup Script"
cp /opt/install/Nzbhydra/nzbhydra.service /etc/systemd/system/
chmod 644 /etc/systemd/system/nzbhydra.service
systemctl enable nzbhydra.service
systemctl restart nzbhydra.service 
