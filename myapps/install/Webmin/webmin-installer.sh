#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"
Programloc=/opt/Webmin   #need to update for restore nad backup 
backupdir=/opt/backup/Webmin   #
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt update
	echo "<-- Installing Deps and Webmin -->"
	apt install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y
	sleep 10
	wget http://www.webmin.com/download/deb/webmin-current.deb -O /opt/install/Webmin/webmin_all.deb
	dpkg -i /opt/install/Webmin/webmin_all.deb
	sleep 1
	echo "Creating Startup Script"
	update-rc.d webmin remove
	cp /opt/install/Webmin/webmin.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/webmin.service
	systemctl enable webmin.service
	systemctl restart webmin.service
	;;
	(-r)
	echo "<--- Restoring Webmin Settings --->"
	echo "Stopping Webmin"
	systemctl stop webmin
	cat /opt/install/Webmin/Webmin.txt > /etc/webmin/miniserv.conf
	cat /opt/install/Webmin/config > /etc/webmin/system-status/config
	echo "Starting up Webmin"
	systemctl start webmin
	;;
	(-b)
	echo "Stopping Webmin"
    	systemctl stop webmin
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Webmin to /opt/backup"
	cp -rf /opt/HTPCManager/userdata $backupdir
    	tar -zcvf /opt/backup/Webmin_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Webmin"
	systemctl start webmin
	;;



