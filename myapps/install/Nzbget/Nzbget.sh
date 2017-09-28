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

#Web-interface is on http://127.0.0.2:6789 (login:nzbget, password:tegbzn6789) - Default settings

#Modes (Variables)
# b=backup i=install r=restore u=update(coming soon)
mode="$1"
Programloc=/opt/Nzbget
backupdir=/opt/backup/Nzbget

case $mode in
	(-i|"")
	echo "Setting up User Account and Downloading Nzbget"
	adduser --disabled-password --system --home /opt/ProgramData/Nzbget --gecos "Nzbget Service" --group Nzbget
	cd /opt && wget https://nzbget.net/download/nzbget-latest-bin-linux.run
	echo "Installing NZBget"
	sh nzbget-latest-bin-linux.run --destdir $Programloc
	rm -f /opt/nzbget-latest-bin-linux.run
	chown -R Nzbget:Nzbget $Programloc
	chmod -R 0777 $Programloc
	sed -i "/DaemonUsername=/c\DaemonUsername=Nzbget" $Programloc/nzbget.conf
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
	cd /opt/backup
	tar -xvzf /opt/backup/Nzbget_Backup.tar.gz
	cp -rf nzbget.conf $Programloc/; rm -rf nzbget.conf
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
	cd $backupdir
    	tar -zcvf /opt/backup/Nzbget_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Nzbget"
	systemctl start nzbget
	;;
	(-u)
	cd /opt && wget https://nzbget.net/download/nzbget-latest-bin-linux.run
	sh nzbget-latest-bin-linux.run --destdir /opt/Nzbget
	rm -f /opt/nzbget-latest-bin-linux.run
	;;
	    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	#echo "-u for Update"
	exit 0;;
esac
exit 0
