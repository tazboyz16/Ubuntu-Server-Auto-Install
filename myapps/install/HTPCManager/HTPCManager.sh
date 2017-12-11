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

Programloc=/opt/HTPCManager
backupdir=/opt/backup/HTPCManager

case $mode in
	(-i|"")
	apt update
	apt install libjpeg-dev libpng12-dev libfreetype6-dev zlib1g-dev libc6-dev libc-dev libjpeg8-dev python python*-requests -y
	adduser --disabled-password --system --home /opt/ProgramData/HTPCManager --gecos "HTPCManager Service" --group HTPCManager
	git clone https://github.com/styxit/HTPC-Manager.git /opt/HTPCManager
	chown -R HTPCManager:HTPCManager /opt/HTPCManager
	chmod -R 0777 /opt/HTPCManager
	rm -rf /opt/HTPCManager/libs/requests; ln -sf /usr/lib/python3/dist-packages/requests /opt/HTPCManager/libs/
	echo "Creating Startup Script"
	cp /opt/install/HTPCManager/HTPCManager.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/HTPCManager.service
	systemctl enable HTPCManager.service
	systemctl restart HTPCManager.service
	#Checking if Iptables is installed and updating with port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 8085 -j ACCEPT/-A INPUT -p tcp --dport 8085 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
        fi
	;;
	(-r)
	echo "<--- Restoring HTPCManager Settings --->"
	echo "Stopping HTPCManager"
	systemctl stop HTPCManager
	cd /opt/backup
	tar -xvzf /opt/backup/HTPCManager_Backup.tar.gz
	rm -rf /opt/HTPCManager/userdata/database.db; cp -rf database.db /opt/HTPCManager/userdata
	chown -R HTPCManager:HTPCManager /opt/HTPCManager
	chmod -R 0777 /opt/HTPCManager
	echo "Starting up HTPCManager"
	systemctl start HTPCManager
	;;
	(-b)
	echo "Stopping HTPCManager"
    	systemctl stop HTPCManager
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up HTPCManager to /opt/backup"
	cp -rf /opt/HTPCManager/userdata/database.db $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/HTPCManager_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up HTPCManager"
	systemctl start HTPCManager
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "HTPCManager not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping HTPCManager to Update"
	sudo systemctl stop HTPCManager
	sleep 5
	cd $Programloc
	git pull
	echo "Starting HTPCManager"
	sudo systemctl start HTPCManager
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "HTPCManager not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping HTPCManager to Force Update"
	sudo systemctl stop HTPCManager
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting HTPCManager"
	sudo systemctl start HTPCManager
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
