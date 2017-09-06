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
# b=(backup) i=(install) r=(restore) u=(update) U=(Force Update) proxy=(Reverse Proxy) port=(Change port)
mode="$1"
Programloc=/opt/CouchPotato
backupdir=/opt/backup/CouchPotato

case $mode in
	(-i|"")
	apt update
	apt install git-core python python-cheetah python-pyasn1 python3-lxml -y
	adduser --disabled-password --system --home /opt/ProgramData/Couchpotato --gecos "CouchPotato Service" --group Couchpotato
	echo "<--- Downloading latest CouchPotato --->"
	cd /opt && sudo git clone https://github.com/CouchPotato/CouchPotatoServer.git /opt/CouchPotato
	chown -R Couchpotato:Couchpotato $Programloc
	chmod -R 0777 $Programloc
	echo "Creating Startup Script"
	cp /opt/install/CouchPotato/couchpotato.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/couchpotato.service
	systemctl enable couchpotato.service
	systemctl restart couchpotato.service 
	;;
	(-r)
	echo "<--- Restoring CouchPotato Settings --->"
	echo "Stopping CouchPotato"
	systemctl stop couchpotato
	chmod -R 0777 /opt/ProgramData/Couchpotato
	tar -xvzf /opt/backup/CouchPotato_Backup.tar.gz $backupdir
	cp /opt/backup/CouchPotato/settings.conf /opt/ProgramData/Couchpotato/.couchpotato/
	rm -rf $backupdir
	echo "Starting CouchPotato"
    	systemctl start couchpotato	
	;;
	(-b)
	echo "Stopping CouchPotato"
    	systemctl stop couchpotato
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up CouchPotato to /opt/backup"
	cp /opt/ProgramData/Couchpotato/.couchpotato/settings.conf $backupdir
    	tar -zcvf /opt/backup/CouchPotato_Backup.tar.gz $backupdir
	rm -rf $backupdir
    	echo "Restarting up CouchPotato"
	systemctl start couchpotato
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "CouchPotato not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping CouchPotato to Update"
	sudo systemctl stop couchpotato
	sleep 5
	cd $Programloc
	git pull
	echo "Starting CouchPotato"
	sudo systemctl start couchpotato
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "CouchPotato not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping CouchPotato to Force Update"
	sudo systemctl stop couchpotato
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting CouchPotato"
	sudo systemctl start couchpotato
	;;
	(-proxy)
	sudo systemctl stop couchpotato
	sed -i 's#.*url_base = .*#url_base = /couchpotato#' /opt/ProgramData/Couchpotato/.couchpotato/settings.conf
	systemctl restart apache2 couchpotato
	;;
	(-port)
	echo "What Port Number Would you like to change CouchPotato to?"
	read Port
	sudo systemctl stop couchpotato
	sed -i "s#port = .*#port = $Port#" /opt/ProgramData/Couchpotato/.couchpotato/settings.conf
	sed -i "s#1:.*/couchpotato#1:$Port/couchpotato#" /etc/apache2/sites-available/000-default.conf
	echo "Changed Port over to $Port"
	systemctl restart apache2 couchpotato
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
