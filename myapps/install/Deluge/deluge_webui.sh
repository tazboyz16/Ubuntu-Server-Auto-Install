#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"

Programloc=/var/lib/deluge
backupdir=/opt/backup/Deluge
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	## get packages required to build deluge ##
	echo "<--- Adding Deluge Team Dep Packages--->"
	add-apt-repository -y ppa:deluge-team/ppa
	apt get update
	## setup deluge user
	echo "<--- Now we will setup a user for Deluge --->"
	adduser --disabled-password --system --home /var/lib/deluge --gecos "Deluge service" --group deluge
	touch /var/log/deluged.log
	touch /var/log/deluge-web.log
	chown deluge:deluge /var/log/deluge*
	apt get update; apt install deluged deluge-webui -y
	echo "Creating Startup Scripts For Deluged and Deluge-WebUI"
	cp /opt/install/Deluge/deluged.service /etc/systemd/system/
	cp /opt/install/Deluge/deluge-web.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/deluged.service
	chmod 644 /etc/systemd/system/deluge-web.service
	systemctl enable deluged.service
	systemctl enable deluge-web.service
	systemctl start deluged
	systemctl start deluge-web
	sleep 15
	;;
	(-r)
	echo "<--Restoring Deluge Settings -->"
	echo "Stopping Deluge"
	#defaults settings stored at /var/lib/deluge/.config/deluge
	#core.conf and web.conf
	#cp /opt/install/Deluge/core.conf /var/lib/deluge/.config/deluge
	#cp /opt/install/Deluge/web.conf /var/lib/deluge/.config/deluge
	systemctl stop deluged
	systemctl stop deluge-web
	sleep 15
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Deluge/core.conf $Programloc/.config/deluge
	cp /opt/install/Deluge/web.conf $Programloc/.config/deluge
	echo "Restarting up Deluge"
	systemctl start deluged
	systemctl start deluge-web
	;;
	(-b)
	echo "Stopping Deluge"
    	systemctl stop deluged
	systemctl stop deluge-web
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Deluge to /opt/backup"
	cp $Programloc/.config/deluge/core.conf $backupdir
	cp $Programloc/.config/deluge/web.conf $backupdir
	tar -zcvf /opt/backup/Deluged_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Deluge"
	systemctl start deluged
	systemctl stop deluge-web
	;;
	(-d)
	stringa=' "default_daemon":* '
	stringb=' "default_daemon": "127.0.0.1:58846" '
	sed -i "s#$stringa#$stringb#"
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
