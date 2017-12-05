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
# b=backup i=install r=restore u=update(coming soon) 
mode="$1"
Programloc=/opt/Ubooquity
backupdir=/opt/backup/Ubooquity

case $mode in
	(-i|"")
	adduser --disabled-password --system --home /opt/ProgramData/Ubooquity --gecos "Ubooquity Service" --group Ubooquity
	add-apt-repository -y ppa:webupd8team/java
	apt update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt install oracle-java8-installer unzip -y
	mkdir -p $Programloc
	cd $Programloc
	wget "http://vaemendis.net/ubooquity/service/download.php" -O Ubooquity.zip
	unzip Ubooquity*.zip
	rm Ubooquity*.zip
	chmod 0777 -R $Programloc
	chown -R Ubooquity:Ubooquity $Programloc
	echo "Creating Startup Script"
	cp /opt/install/Ubooquity/ubooquity.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/ubooquity.service
	systemctl enable ubooquity.service
	systemctl restart ubooquity.service
	#Checking if Iptables is installed and updating with CP port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 2202 -j ACCEPT/-A INPUT -p tcp --dport 2202 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 2203 -j ACCEPT/-A INPUT -p tcp --dport 2203 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-r)
	echo "<--- Restoring Ubooquity Settings --->"
	echo "Stopping Ubooquity"
	systemctl stop ubooquity
	cd /opt/backup
	tar -xvzf /opt/backup/Ubooquity_Backup.tar.gz
	cp -rf preferences.json $Programloc; rm -rf preferences.json
	cp -rf ubooquity-5.mv.db $Programloc; rm -rf ubooquity-5.mv.db
	cp -rf webadmin.cred $Programloc; rm -rf webadmin.cred
	chown -R Ubooquity:Ubooquity $Programloc; 
	chmod -R 0777 $Programloc
	echo "Starting up Ubooquity"
	systemctl start ubooquity
	;;
	(-b)
	echo "Stopping Ubooquity"
    	systemctl stop ubooquity
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Ubooquity to /opt/backup"
	cp -rf $Programloc/preferences.json $backupdir
	cp -rf $Programloc/ubooquity-5.mv.db $backupdir
	cp -rf $Programloc/webadmin.cred $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/Ubooquity_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Ubooquity"
	systemctl start ubooquity
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	#echo "-u for Update"
	exit 0;;
esac
exit 0
