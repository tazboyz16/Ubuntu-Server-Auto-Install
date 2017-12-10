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

versionm=$(lsb_release -cs)

#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"
Programloc=/opt/Ombi
backupdir=/opt/backup/Ombi



case $mode in
	(-i|"")
	echo "Installing PlexRequests.NET (Ombi)"
		if [ ! -f /etc/apt/sources.list.d/mono-xamarin.list ]; then
		apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
		echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
		fi
	apt update; apt install mono-complete unzip -y
	adduser --disabled-password --system --home /opt/ProgramData/Ombi --gecos "Ombi Service" --group ombi
	mkdir /opt/Ombi && cd $Programloc
	wget $(curl -s https://api.github.com/repos/tidusjar/Ombi/releases/latest | grep 'browser_' | cut -d\" -f4)
	unzip Ombi.zip; rm Ombi.zip
	cp -rf Release/* .; rm -rf Release/
	chown -R ombi:ombi $Programloc
	chmod -R 0777 $Programloc
	echo "Creating Startup Script for PlexRequests"
	cp /opt/install/Plex/ombi.service /etc/systemd/system/
	chmod 0777 /etc/systemd/system/ombi.service
	systemctl enable ombi.service
	systemctl restart ombi.service
	#Checking if Iptables is installed and updating with port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 3579 -j ACCEPT/-A INPUT -p tcp --dport 3579 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-r)
	echo "<--Restoring Ombi Settings -->"
	echo "Stopping Ombi"
	systemctl stop ombi
	cd /opt/backup
	tar -xvzf /opt/backup/Ombi_Backup.tar.gz
	cp -rf Ombi.sqlite $Programloc; rm -rf Ombi.sqlite
	echo "Restarting up Ombi"
	systemctl start ombi
	;;
	(-b)
	echo "Stopping Ombi"
    	systemctl stop ombi
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Ombi to /opt/backup"
	cp $Programloc/Ombi.sqlite $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Ombi_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Ombi"
	systemctl start ombi
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
