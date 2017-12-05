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
	cd /opt && git clone https://github.com/JonnyWong16/plexpy.git $Programloc
	chown -R plexpy:plexpy $Programloc
	chmod -R 0777 $Programloc
	echo "Creating Startup Script for PlexPy"
	cp /opt/install/Plex/plexpy.service /etc/systemd/system/
	chmod 0777 /etc/systemd/system/plexpy.service
	systemctl enable plexpy.service
	systemctl restart plexpy.service
	#Checking if Iptables is installed and updating with CP port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 8181 -j ACCEPT/-A INPUT -p tcp --dport 8181 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
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
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	#echo "-u for Update"
	exit 0;;
esac
exit 0
