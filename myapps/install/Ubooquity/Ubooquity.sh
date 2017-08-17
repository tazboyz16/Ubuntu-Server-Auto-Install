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
# b=backup i=install r=restore u=update(coming soon) 
mode="$1"
Programloc=/opt/Ubooquity
backupdir=/opt/backup/Ubooquity
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	adduser --disabled-password --system --home /opt/ProgramData/Ubooquity --gecos "Ubooquity Service" --group Ubooquity
	add-apt-repository -y ppa:webupd8team/java
	apt update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt install oracle-java8-installer unzip -y
	mkdir -p /opt/Ubooquity
	cd /opt/Ubooquity
	wget "http://vaemendis.net/ubooquity/service/download.php" -O Ubooquity.zip
	unzip Ubooquity*.zip
	rm Ubooquity*.zip
	chmod 0777 -R /opt/Ubooquity
	chown -R Ubooquity:Ubooquity /opt/Ubooquity
	echo "Creating Startup Script"
	cp /opt/install/Ubooquity/ubooquity.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/ubooquity.service
	systemctl enable ubooquity.service
	systemctl restart ubooquity.service
	;;
	(-r)
	echo "<--- Restoring Ubooquity Settings --->"
	echo "Stopping Ubooquity"
	systemctl stop ubooquity
	cat /opt/install/Ubooquity/HTPCManager.txt > /opt/HTPCManager/userdata
	chown -R Ubooquity:Ubooquity /opt/Ubooquity
	chmod -R 0777 /opt/Ubooquity
	echo "Starting up Ubooquity"
	systemctl start ubooquity
	;;
	(-b)
	echo "Stopping Ubooquity"
    	systemctl stop ubooquity
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Ubooquity to /opt/backup"
	cp -rf /opt/Ubooquity/userdata $backupdir
    	tar -zcvf /opt/backup/Ubooquity_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Ubooquity"
	systemctl start ubooquity
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
