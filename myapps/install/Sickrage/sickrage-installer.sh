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

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"
Programloc=/opt/SickRage
backupdir=/opt/backup/SickRage

case $mode in
	(-i|"")
	apt update
	apt install git-core unrar-free openssl libssl-dev python -y
	#You may need to install nodejs for some of the Search Providers 
	adduser --disabled-password --system --home /opt/ProgramData/Sickrage --gecos "Sickrage Service" --group Sickrage
	echo '<--- Downloading latest SickRage --->'
	cd /opt && git clone https://github.com/SickRage/SickRage.git 
	chown -R Sickrage:Sickrage /opt/SickRage
	chmod -R 0777 /opt/SickRage
	echo "Creating Startup Script"
	cp /opt/install/Sickrage/sickrage.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/sickrage.service
	systemctl enable sickrage.service
	systemctl restart sickrage.service
	#Checking if Iptables is installed and updating with CP port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 8081 -j ACCEPT/-A INPUT -p tcp --dport 8081 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-r)
	echo "<--- Restoring SickRage Settings --->"
	echo "Stopping SickRage"
	systemctl stop sickrage
	cd /opt/backup
	tar -xvzf /opt/backup/Sickrage_Backup.tar.gz
	cp -rf cache/ $Programloc; rm -rf cache/
	cp -rf failed.db $Programloc; rm -rf failed.db
	cp -rf sickbeard.db $Programloc; rm -rf sickbeard.db
	cp -rf cache.db $Programloc; rm -rf cache.db
    	cp -rf config.ini $Programloc; rm -rf config.ini
	echo "Starting SickRage"
    	systemctl start sickrage	
	;;
	(-b)
	echo "Stopping SickRage"
    	systemctl stop sickrage
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up SickRage to /opt/backup"
	#backup files are in sickrage install location for items Cache Folder, failed.db,sickbeard.db, and cache.db
	cp -rf $Programloc/cache/ $backupdir
	cp -rf $Programloc/failed.db $backupdir
	cp -rf $Programloc/sickbeard.db $backupdir
	cp -rf $Programloc/cache.db $backupdir
    	cp -rf $Programloc/config.ini $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Sickrage_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up SickRage"
	systemctl start sickrage
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "SickRage not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping SickRage to Update"
	sudo systemctl stop sickrage
	sleep 5
	cd $Programloc
	git pull
	echo "Starting SickRage"
	sudo systemctl start sickrage
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "SickRage not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping SickRage to Force Update"
	sudo systemctl stop sickrage
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting SickRage"
	sudo systemctl start sickrage
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	echo "-u for Update"
	echo "-U for Force Update"
	exit 0;;
esac
exit 0
