#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

Programloc=/opt/HTPC-Manager
backupdir=/opt/backup/HTPC-Manager
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt install libjpeg-dev libpng12-dev libfreetype6-dev zlib1g-dev libc6-dev libc-dev libjpeg8-dev python -y
	adduser --disabled-password --system --home /opt/ProgramData/HTPCManager --gecos "HTPCManager Service" --group HTPCManager
	git clone https://github.com/styxit/HTPC-Manager.git /opt/HTPCManager
	chown -R HTPCManager:HTPCManager /opt/HTPCManager
	chmod -R 0777 /opt/HTPCManager
	echo "Creating Startup Script"
	cp /opt/install/HTPCManager/HTPCManager.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/HTPCManager.service
	systemctl enable HTPCManager.service
	systemctl restart HTPCManager.service
	;;
	(-r)
	echo "<--- Restoring HTPCManager Settings --->"
	echo "Stopping HTPCManager"
	systemctl stop HTPCManager
	cat /opt/install/HTPCManager/HTPCManager.txt > /opt/HTPC-Manager/userdata
	chown -R HTPCManager:HTPCManager /opt/HTPC-Manager
	chmod -R 0777 /opt/HTPC-Manager
	echo "Starting up HTPCManager"
	systemctl start HTPCManager
	;;
	(-b)
	echo "Stopping HTPCManager"
    	systemctl stop HTPCManager
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up HTPCManager to /opt/backup"
	cp /opt/HTPC-Manager/userdata $backupdir
    	tar -zcvf /opt/backup/HTPCManager_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up HTPCManager"
	systemctl start HTPCManager
	;;
	(-u)
	echo "Stopping HTPCManager to Update"
	sudo systemctl stop HTPCManager
	sleep 5
	cd $Programloc
	git pull
	echo "Starting HTPCManager"
	sudo systemctl start HTPCManager
	;;
	(-U)
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
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
