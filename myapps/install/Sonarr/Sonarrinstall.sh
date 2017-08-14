#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

versionm=$(lsb_release -cs)
#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

Programloc=/opt/NzbDrone
backupdir=/opt/backup/Sonarr
time=$(date +"%m_%d_%y-%H_%M")

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
	echo "Creating Startup Script"
	cp /opt/install/Sonarr/sonarr.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/sonarr.service
	systemctl enable sonarr.service
	systemctl restart sonarr.service
	;;
	(-r)
	echo "<--- Restoring Sonarr Settings --->"
	echo "Stopping Sonarr"
	systemctl stop sonarr
	chmod -R 0777 /opt/ProgramData/Sonarr
	cp /opt/install/Sonarr/CouchPotato.txt /opt/ProgramData/Sonarr/.couchpotato/settings.conf
	echo "Starting Sonarr"
    	systemctl start sonarr	
	;;
	(-b)
	echo "Stopping Sonarr"
    	systemctl stop sonarr
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Sonarr to /opt/backup"
	cp /opt/Sonarr/Data $backupdir
    	tar -zcvf /opt/backup/Sonarr_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Sonarr"
	systemctl start sonarr
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
