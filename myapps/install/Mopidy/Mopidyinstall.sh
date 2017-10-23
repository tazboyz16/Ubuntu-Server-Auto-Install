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

#~/.config/mopidy/mopidy.conf -Main config file
#/etc/mopidy/mopidy.conf
#mopidy config to effective configuration
#https://docs.mopidy.com/en/latest/service/#service
#have to edit http section to enable outside localhost connections
# http://localhost:6680/moped & http://localhost:6680/mopify

#Modes (Variables)
# b=(backup) i=(install) r=(restore) u=(update) U=(Force Update) proxy=(Reverse Proxy) port=(Change port)
mode="$1"
Programloc=~/.config/mopidy/
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
	echo "<--- Restoring Mopidy Settings --->"
	echo "Stopping Mopidy"
	systemctl stop mopidy
	chmod -R 0777 ~/.config/
	cd /opt/backup
	tar -xvzf /opt/backup/Mopidy_Backup.tar.gz
	cp -rf mopidy.conf ~/.config/mopidy/; rm -rf mopidy.conf 
	echo "Starting up Mopidy"
	systemctl start mopidy
	;;
	(-b)
	echo "Stopping Mopidy"
  	systemctl stop mopidy
 	echo "Making sure Backup Dir exists"
  	mkdir -p $backupdir
  	echo "Backing up Mopidy to /opt/backup"
	cp -rf $Programloc/mopidy.conf $backupdir
	cd $backupdir
  	tar -zcvf /opt/backup/Mopidy_Backup.tar.gz *
	rm -rf $backupdir
  	echo "Restarting up Mopidy"
	systemctl start mopidy
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	exit 0;;
esac
exit 0	
