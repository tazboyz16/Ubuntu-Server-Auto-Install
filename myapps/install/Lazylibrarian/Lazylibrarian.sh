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

case $mode in
	(-i|"")
	apt update
	apt install python -y
	adduser --disabled-password --system --home /opt/ProgramData/LazyLibrarian --gecos "LazyLibrarian Service" --group LazyLibrarian
   	cd /opt &&  git clone https://github.com/DobyTang/LazyLibrarian.git
   	chown -R LazyLibrarian:LazyLibrarian /opt/LazyLibrarian
   	chmod -R 0777 /opt/LazyLibrarian
	#config file will not show up till after making any changes to settings so doing a default copy 
	cp /opt/install/Lazylibrarian/config.ini $Programloc/config.ini
  	echo "Creating Startup Script"
   	cp /opt/install/Lazylibrarian/LazyLibrarian.service /etc/systemd/system/
   	chmod 644 /etc/systemd/system/LazyLibrarian.service
   	systemctl enable LazyLibrarian.service
   	systemctl restart LazyLibrarian.service
	#Checking if Iptables is installed and updating with port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 5299 -j ACCEPT/-A INPUT -p tcp --dport 5299 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
   	;;
   	(-r)
	echo "<--Restoring LazyLibrarian Settings -->"
	echo "Stopping LazyLibrarian"
	systemctl stop LazyLibrarian
	sudo chmod 0777 -R $Programloc
	cd /opt/backup
	tar -xvzf /opt/backup/LazyLibrarian_Backup.tar.gz
	cp -rf config.ini $Programloc; rm -rf config.ini	
	echo "Restarting up LazyLibrarian"
	systemctl start LazyLibrarian
	;;
	(-b)
	echo "Stopping LazyLibrarian"
    	systemctl stop LazyLibrarian
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up LazyLibrarian to /opt/backup"
	cp $Programloc/config.ini $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/LazyLibrarian_Backup.tar.gz *
	rm -rf $backupdir
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
 	systemctl stop LazyLibrarian
	sed -i 's#.*http_root = .*#http_root = /lazylibrarian#' /opt/LazyLibrarian/config.ini
	systemctl restart apache2 LazyLibrarian
	;;
	(-port)
	echo "What Port Number Would you like to change LazyLibrarian to?"
	read Port
	systemctl stop LazyLibrarian
	sed -i "s#http_port = .*#http_port = $Port#" /opt/LazyLibrarian/config.ini
	sed -i "s#1:.*/lazylibrarian#1:$Port/lazylibrarian#" /etc/apache2/sites-available/000-default.conf
	echo "Changed Port over to $Port"
	systemctl restart apache2 LazyLibrarian
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	echo "-u for Update"
	echo "-U for Force Update"
	echo "-proxy for Reverse Proxy"
	echo "-port for change port"
	exit 0;;
esac
exit 0
