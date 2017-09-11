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
Programloc=/opt/Jackett
backupdir=/opt/backup/Jackett

case $mode in
	(-i|"")
	adduser --disabled-password --system --home /opt/ProgramData/Jackett --gecos "Jackett Service" --group Jackett
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
	apt update
	apt install mono-complete libcurl4-openssl-dev -y
	wget $(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep 'Jackett.Binaries.Mono.tar.gz' | cut -d\" -f4)
	tar -xvf Jackett.Binaries.Mono.tar.gz && sudo rm Jackett.Binaries.Mono.tar.gz
	mkdir /opt/Jackett
	mv Jackett/* /opt/Jackett
	chmod 0777 -R /opt/Jackett
	chown -R Jackett:Jackett /opt/Jackett
	echo "Creating Startup Script"
	cp /opt/install/Jackett/jackett.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/jackett.service
	systemctl enable jackett.service
	systemctl restart jackett.service
	;;
	(-r)
	echo "<--Restoring Jackett Settings -->"
	echo "Stopping Jackett"
	systemctl stop jackett
	chmod 0777 -R $Programloc /opt/ProgramData/Jackett
	cd /opt/backup
	tar -xvzf /opt/backup/Jackett_Backup.tar.gz
	cp ServerConfig.json /opt/ProgramData/Jackett/.config/Jackett; rm -rf ServerConfig.json
	echo "Restarting up Jackett"
	systemctl start jackett
	;;
	(-b)
	echo "Stopping Jackett"
    	systemctl stop jackett
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Jackett to /opt/backup"
	chmod 0777 -R /opt/ProgramData/Jackett
	cp /opt/ProgramData/Jackett/.config/Jackett/ServerConfig.json $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Jackett_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Jackett"
	systemctl start jackett
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
