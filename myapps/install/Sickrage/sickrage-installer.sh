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

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"
Programloc=/opt/SickRage
backupdir=/opt/backup/SickRage
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	echo '<--- Installing SickRage --->'
	apt update
	apt install git-core unrar-free openssl libssl-dev python -y
	adduser --disabled-password --system --home /opt/ProgramData/Sickrage --gecos "Sickrage Service" --group Sickrage
	echo '<--- Downloading latest SickRage --->'
	cd /opt && git clone https://github.com/SickRage/SickRage.git 
	chown -R Sickrage:Sickrage /opt/SickRage
	chmod -R 0777 /opt/SickRage
	echo "Creating Startup Script"
	cp /opt/install/SickRage/sickrage.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/sickrage.service
	systemctl enable sickrage.service
	systemctl restart sickrage.service
	;;
	(-r)
	echo "<--- Restoring SickRage Settings --->"
	echo "Stopping SickRage"
	systemctl stop sickrage
	chmod -R 0777 /opt/ProgramData/Sickrage
	#NEEDS TO BE EDITED FOR UNZIP TAR FILE TO RESTORE SETTINGS VS SINGLE FILE RESTORE
	cp /opt/install/CouchPotato/CouchPotato.txt /opt/ProgramData/Couchpotato/.couchpotato/settings.conf
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
	cp /opt/ProgramData/Sickrage/.couchpotato/settings.conf $backupdir
    	tar -zcvf /opt/backup/Sickrage_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up SickRage"
	systemctl start sickrage
	;;
	(-u)
	echo "Stopping SickRage to Update"
	sudo systemctl stop sickrage
	sleep 5
	cd $Programloc
	git pull
	echo "Starting SickRage"
	sudo systemctl start sickrage
	;;
	(-U)
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
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
