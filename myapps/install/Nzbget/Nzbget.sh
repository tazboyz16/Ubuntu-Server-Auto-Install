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

#Successfully installed into /home/cabox/workspace/nzbget
#Web-interface is on http://127.0.0.2:6789 (login:nzbget, password:tegbzn6789) - Default settings

#Modes (Variables)
# b=backup i=install r=restore u=update(coming soon)
mode="$1"
Programloc=/opt/Nzbget
backupdir=/opt/backup/Nzbget
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	echo "Setting up User Account and Downloading Nzbget"
	adduser --disabled-password --system --home /opt/ProgramData/Nzbget --gecos "Nzbget Service" --group Nzbget
	cd /opt && wget https://nzbget.net/download/nzbget-latest-bin-linux.run
	echo "Installing NZBget"
	sh nzbget-latest-bin-linux.run --destdir /opt/Nzbget
	rm -f /opt/nzbget-latest-bin-linux.run
	sed -i "/DaemonUsername=/c\DaemonUsername=Nzbget" /opt/Nzbget/nzbget.conf
	echo "Creating Startup Script"
	cp /opt/install/Nzbget/nzbget.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/nzbget.service
	systemctl enable nzbget.service
	systemctl restart nzbget.service
	;;
	(-r)
	echo "<--- Restoring Nzbget Settings --->"
	echo "Stopping Nzbget"
	systemctl stop nzbget
	cp /opt/install/Nzbget/nzbget.conf  $Programloc/
	chown -R Nzbget:Nzbget /opt/Nzbget
	chmod -R 0777 /opt/Nzbget
	echo "Starting up nzbget"
	systemctl start nzbget
	;;
	(-b)
	echo "Stopping Nzbget"
    	systemctl stop nzbget
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Nzbget to /opt/backup"
	cp -rf $Programloc/nzbget.conf $backupdir
    	tar -zcvf /opt/backup/Nzbget_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Nzbget"
	systemctl start nzbget
	;;
	(-u)
	cd /opt && wget https://nzbget.net/download/nzbget-latest-bin-linux.run
	sh nzbget-latest-bin-linux.run --destdir /opt/Nzbget
	rm -f /opt/nzbget-latest-bin-linux.run
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
