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
# b=backup(coming soon) i=install r=restore u=update
mode="$1"
Programloc=/opt/Organizr
backupdir=/opt/backup/Organizr

case $mode in
	(-i|"")
	echo "Setting up Organizr User"
	adduser --disabled-password --system --home /opt/ProgramData/Organizer --gecos "Organizr Service" --group Organizr
	bash /opt/install/Apache2/Apache2-install.sh
	apt update
	apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
	apt remove php7.0-snmp -y
	echo "Installing Organizr"
	cd /opt && git clone https://github.com/causefx/Organizr.git
	chown -R Organizr:Organizr /opt/Organizr
	chmod -R 0777 /opt/Organizr
	service apache2 restart
	;;
	(-r)
	echo "<--- Restoring Organizr Settings --->"
	echo "Stopping Apache2 for Organizr"
	systemctl stop apache2
	cd /opt/backup
	tar -xvzf /opt/backup/Organizr_Backup.tar.gz
	cp -rf Organizr/ /opt; rm -rf Organizr/
	chown -R Organizr:Organizr /opt/Organizr
	chmod -R 0777 /opt/Organizr
	echo "Restarting up Apache2 for Organizr"
	systemctl restart apache2
	;;
	(-b)
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Organizr to /opt/backup"
	cp -rf /opt/Organizr/ $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/Organizr_Backup.tar.gz *
	rm -rf $backupdir
	;;
	(-u)
		#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Organizr not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Organizr to Update"
	sleep 5
	cd $Programloc
	git pull
	;;
	(-U)
		#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Organizr not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Organizr to Force Update"
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
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
