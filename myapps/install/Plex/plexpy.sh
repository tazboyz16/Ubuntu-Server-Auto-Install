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
# b=backup i=install r=restore 
mode="$1"
Programloc=/opt/Plexpy
backupdir=/opt/backup/Plexpy

case $mode in
	(-i|"")
	echo "Installing PlexPy"
	apt update
	apt install python -y
	adduser --disabled-password --system --home /opt/ProgramData/PlexPy --gecos "PlexPy Service"  --group plexpy
	cd /opt && git clone https://github.com/JonnyWong16/plexpy.git /opt/Plexpy
	#echo "<--- Restoring PLexPy Settings --->"
	#cat /opt/install/PlexAddons/Headphones.txt > /opt/.headphones/config.ini
	chown -R plexpy:plexpy /opt/Plexpy
	chmod -R 0777 /opt/Plexpy
	echo "Creating Startup Script for PlexPy"
	cp /opt/install/Plex/plexpy.service /etc/systemd/system/
	chmod 0777 /etc/systemd/system/plexpy.service
	systemctl enable plexpy.service
	systemctl restart plexpy.service
	;;
	(-r)
	echo "<--Restoring Plexpy Settings -->"
	echo "Stopping Plexpy"
	systemctl stop plexpy
	cd /opt/backup
	tar -xvzf /opt/backup/Plexpy_Backup.tar.gz
	cp -rf plexpy.db /opt/Plexpy/; rm -rf  plexpy.db
	cp -rf config.ini /opt/Plexpy/; rm -rf config.ini
	echo "Restarting up Plexpy"
	systemctl start plexpy
	;;
	(-b)
	echo "Stopping Plexpy"
    	systemctl stop plexpy
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Plexpy to /opt/backup"
	cp /opt/Plexpy/plexpy.db $backupdir
	cp /opt/Plexpy/config.ini $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Plexpy_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Plexpy"
	systemctl start plexpy
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
