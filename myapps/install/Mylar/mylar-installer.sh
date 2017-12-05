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
Programloc=/opt/Mylar
backupdir=/opt/backup/Mylar

case $mode in
	(-i|"")
	echo '<--- Installing prerequisites for Mylar --->'
	apt update
	apt install git-core python python-cheetah python-pyasn1 -y
	adduser --disabled-password --system --home /opt/ProgramData/mylar --gecos "Mylar Service" --group Mylar
	echo '<--- Downloading latest Mylar --->'
	cd /opt && sudo git clone https://github.com/evilhero/mylar.git /opt/Mylar
	chown -R Mylar:Mylar /opt/Mylar
	chmod -R 0777 /opt/Mylar
	echo "Creating Startup Script"
	cp /opt/install/Mylar/mylar.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/mylar.service
	systemctl enable mylar.service
	systemctl restart mylar.service
	#Checking if Iptables is installed and updating with port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 8090 -j ACCEPT/-A INPUT -p tcp --dport 8090 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-r)
	echo "<--- Restoring Mylar Settings --->"
	echo "Stopping Mylar"
	systemctl stop mylar
	cd /opt/backup
	tar -xvzf /opt/backup/Mylar_Backup.tar.gz
	cp -rf data/ $Programloc; rm -rf data/
	cp -rf cache/ $Programloc; rm -rf cache/
	cp -rf config.ini $Programloc; rm -rf config.ini
	chown -R Mylar:Mylar /opt/Mylar
	chmod -R 0777 /opt/Mylar
	echo "Starting up Mylar"
	systemctl start mylar
	;;
	(-b)
	echo "Stopping Mylar"
    	systemctl stop mylar
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Mylar to /opt/backup"
	cp -rf /opt/Mylar/data/ $backupdir
	cp -rf /opt/Mylar/cache/ $backupdir
	cp -rf /opt/Mylar/config.ini $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/Mylar_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Mylar"
	systemctl start mylar
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Mylar not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Mylar to Update"
	sudo systemctl stop mylar
	sleep 5
	cd $Programloc
	git pull
	echo "Starting Mylar"
	sudo systemctl start mylar
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Mylar not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Mylar to Force Update"
	sudo systemctl stop mylar
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting Mylar"
	sudo systemctl start mylar
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
