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
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

Programloc=/opt/ProgramData/Sonarr/.config/NzbDrone #Config Location
backupdir=/opt/backup/Sonarr

case $mode in
	(-i|"")
	adduser --disabled-password --system --home /opt/ProgramData/Sonarr --gecos "Sonarr Service" --group Sonarr
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FDA5DFFC
	echo "deb http://apt.sonarr.tv/ master main" | tee /etc/apt/sources.list.d/sonarr.list
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | tee /etc/apt/sources.list.d/mono-offical.list
	apt update
	apt install nzbdrone libmono-cil-dev apt-transport-https mono-devel -y
	chown -R Sonarr:Sonarr /opt/NzbDrone
	chmod -R 0777 /opt/NzbDrone
	echo "Creating Startup Script"
	cp /opt/install/Sonarr/sonarr.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/sonarr.service
	systemctl enable sonarr.service
	systemctl restart sonarr.service
	;;
	(-r)
	echo "<--Restoring Sonarr Settings -->"
	echo "Stopping Sonarr"
	systemctl stop sonarr
	cd /opt/backup
	tar -xvzf /opt/backup/Sonarr_Backup.tar.gz
	cp config.xml $Programloc
	cp -rf logs/ $Programloc; cp -rf logs.db $Programloc; cp -rf logs.db-shm $Programloc; cp -rf logs.db-wal $Programloc
	cp -rf nzbdrone.db $Programloc; cp -rf nzbdrone.db-shm $Programloc; cp -rf nzbdrone.db-wal $Programloc; 
	cp -rf nzbdrone.pid $Programloc
	rm -rf config.xml logs/ logs.db logs.db-shm logs.db-wal nzbdrone.db nzbdrone.db-shm nzbdrone.db-wal nzbdrone.pid
	echo "Restarting up Sonarr"
	systemctl start sonarr
	;;
	(-b)
	echo "Stopping Sonarr"
    	systemctl stop sonarr
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Sonarr to /opt/backup"
	cp -rf $Programloc/* $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Sonarr_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Sonarr"
	systemctl start sonarr
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
