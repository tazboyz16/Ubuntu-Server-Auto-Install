#!/bin/bash

###########################################################
# Created by @tazboyz16
# This Script was created at
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

#Modes (Variables)
# b=(backup) i=(install) r=(restore) u=(update) U=(Force Update) proxy=(Reverse Proxy) port=(Change port)
mode="$1"

Programloc=/opt/LazyLibrarian
backupdir=/opt/backup/LazyLibrarian
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt update
	apt install python -y
	adduser --disabled-password --system --home /opt/ProgramData/LazyLibrarian --gecos "LazyLibrarian Service" --group LazyLibrarian
   	cd /opt &&  git clone https://github.com/DobyTang/LazyLibrarian.git
   	chown -R LazyLibrarian:LazyLibrarian /opt/LazyLibrarian
   	chmod -R 0777 /opt/LazyLibrarian
	cp /opt/install/Lazylibrarian/config.ini $Programloc/config.ini
  	echo "Creating Startup Script"
   	cp /opt/install/Lazylibrarian/LazyLibrarian.service /etc/systemd/system/
   	chmod 644 /etc/systemd/system/LazyLibrarian.service
   	systemctl enable LazyLibrarian.service
   	systemctl restart LazyLibrarian.service
   	;;
   	(-r)
	echo "<--Restoring LazyLibrarian Settings -->"
	echo "Stopping LazyLibrarian"
	systemctl stop LazyLibrarian
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Jackett/ServerConfig.json $Programloc/config.ini
	echo "Restarting up LazyLibrarian"
	systemctl start LazyLibrarian
	;;
	(-b)
	echo "Stopping LazyLibrarian"
    	systemctl stop LazyLibrarian
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
	#config file will not show up till after making any changes to settings
    	echo "Backing up LazyLibrarian to /opt/backup"
	cp $Programloc/config.ini $backupdir
	tar -zcvf /opt/backup/LazyLibrarian_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up LazyLibrarian"
	systemctl start LazyLibrarian
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "LazyLibrarian not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping LazyLibrarian to Update"
	sudo systemctl stop LazyLibrarian
	sleep 5
	cd $Programloc
	git pull
	echo "Starting LazyLibrarian"
	sudo systemctl start LazyLibrarian
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "LazyLibrarin not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping LazyLibrarian to Force Update"
	sudo systemctl stop LazyLibrarian
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting LazyLibrarian"
	sudo systemctl start LazyLibrarian
	;;
	(-proxy)
  systemctl restart LazyLibrarian
	sed -i 's#.*http_root = .*#http_root = /lazylibrarian#' /opt/LazyLibrarian/config.ini
	systemctl restart apache2 LazyLibrarian
	;;
	(-port)
	echo "What Port Number Would you like to change LazyLibrarian to?"
	read Port
	sed -i "s#http_port = .*#http_port = $Port#" /opt/LazyLibrarian/config.ini
	sed -i "s#1:.*/lazylibrarian#1:$Port/lazylibrarian#" /etc/apache2/sites-available/000-default.conf
	echo "Changed Port over to $Port"
	systemctl restart apache2 LazyLibrarian
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
