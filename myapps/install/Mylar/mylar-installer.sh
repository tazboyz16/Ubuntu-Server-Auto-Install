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
Programloc=/opt/Mylar
backupdir=/opt/backup/Mylar
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	echo '<--- Installing prerequisites for Mylar --->'
	apt update
	apt install git-core python python-cheetah python-pyasn1 -y
	adduser --disabled-password --system --home /opt/ProgramData/mylar --gecos "Mylar Service" --group Mylar
	echo '<--- Downloading latest Mylar --->'
	cd /opt && sudo git clone https://github.com/evilhero/mylar.git /opt/Mylar
	echo "Creating Startup Script"
	cp /opt/install/Mylar/mylar.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/mylar.service
	systemctl enable mylar.service
	systemctl restart mylar.service
	;;
	(-r)
	echo "<--- Restoring Mylar Settings --->"
	echo "Stopping Mylar"
	systemctl stop mylar
	cat /opt/install/Mylar/Mylar.txt > /opt/Mylar/config.ini
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
	cp -rf /opt/Mylar/userdata $backupdir
    	tar -zcvf /opt/backup/Mylar_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Mylar"
	systemctl start mylar
	;;
	(-u)
	echo "Stopping Mylar to Update"
	sudo systemctl stop mylar
	sleep 5
	cd $Programloc
	git pull
	echo "Starting Mylar"
	sudo systemctl start mylar
	;;
	(-U)
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
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
