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

#~/.config/mopidy/mopidy.conf
#/etc/mopidy/mopidy.conf
#mopidy config to effective configuration
#https://docs.mopidy.com/en/latest/service/#service
#have to edit http section to enable outside localhost connections
# http://localhost:6680/moped & http://localhost:6680/mopify

#Modes (Variables)
# b=(backup) i=(install) r=(restore) u=(update) U=(Force Update) proxy=(Reverse Proxy) port=(Change port)
mode="$1"
Programloc=/opt/Mopidy
backupdir=/opt/backup/Mopidy

case $mode in
	(-i|"")
	wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
	wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list
	apt update; apt install mopidy python-pip -y
	pip install Mopidy-Moped
	pip install Mopidy-Mopify
	echo "Creating Startup Script"
	cp /opt/install/Mopidy/mopidy.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/mopidy.service
	systemctl enable mopidy.service
	systemctl restart mopidy.service 
	;;
	(-r)
	;;
	(-b)
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0	
