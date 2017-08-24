#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi



wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list
apt update; apt install mopidy python-pip -y

#~/.config/mopidy/mopidy.conf
#/etc/mopidy/mopidy.conf
#mopidy config to effective configuration
#https://docs.mopidy.com/en/latest/service/#service
#have to edit http section to enable outside localhost connections

# http://localhost:6680/moped
pip install Mopidy-Moped
# http://localhost:6680/mopify
pip install mpoidy-mopfiy

echo "Creating Startup Script"
cp /opt/install/Mopidy/mopidy.service /etc/systemd/system/
chmod 644 /etc/systemd/system/mopidy.service
systemctl enable mopidy.service
systemctl restart mopidy.service 
