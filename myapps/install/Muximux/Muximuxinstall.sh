#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update
mode="$1"
Programloc=/opt/Muximux
backupdir=/opt/backup/Muximux
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	echo "Setting up Muximux User"
	adduser --disabled-password --system --home /opt/ProgramData/Muximux --gecos "Muximux Service" --group Muximux
	bash /opt/install/Apache2/Apache2-install.sh
	apt update
	apt install php7.0 php7.0-* openssl libapache2-mod-php7.0 -y
	apt remove php7.0-snmp -y
	echo "Installing Muximux"
	cd /opt && git clone https://github.com/mescon/Muximux.git
	chown -R Muximux:Muximux /opt/Muximux
	chmod -R 0777 /opt/Muximux
	cp /opt/install/Muximux/Muximux.conf /etc/apache2/sites-available/
	a2ensite Muximux.conf
	service apache2 restart
	;;
	(-r)
	echo "<--- Restoring Muximux Settings --->"
	cat /opt/install/Muximux/Mylar.txt > /opt/Muximux/
	chown -R Muximux:Muximux /opt/Muximux
	chmod -R 0777 /opt/Muximux
	;;
	(-b)
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Muximux to /opt/backup"
	cp -rf /opt/Muximux/ $backupdir
    	tar -zcvf /opt/backup/Muximux_FullBackup-$time.tar.gz $backupdir
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ];
		echo "Muximux not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Muximux to Update"
	sleep 5
	cd $Programloc
	git pull
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ];
		echo "Muximux not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Muximux to Force Update"
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
