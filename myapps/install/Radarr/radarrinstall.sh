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
Programloc=/opt/ProgramData/Radarr/.config/Radarr #Config Location
backupdir=/opt/backup/Radarr
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
	apt update 
	apt install libmono-cil-dev curl mediainfo mono-devel -y
	adduser --disabled-password --system --home /opt/ProgramData/Radarr --gecos "Radarr Service" --group Radarr
	echo "<--- Downloading latest Radarr --->"
	cd /opt 
	wget $(curl -s https://api.github.com/repos/radarr/radarr/releases | grep browser_download_url | grep linux.tar.gz | head -n 1 | cut -d '"' -f 4)
	tar -xzf Radarr.develop.*.linux.tar.gz 
	rm -rf Radarr*.tar.gz
	chown -R Radarr:Radarr /opt/Radarr/
	chmod -R 0777 /opt/Radarr
	echo "Creating Startup Script"
	cp /opt/install/Radarr/radarr.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/radarr.service
	systemctl enable radarr.service
	systemctl restart radarr.service
	;;
	(-r)
	echo "<--Restoring Radarr Settings -->"
	echo "Stopping Radarr"
	systemctl stop radarr
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Radarr/ServerConfig.json /opt/ProgramData/Radarr/.config/Radarr/
	echo "Restarting up Radarr"
	systemctl start radarr
	;;
	(-b)
	echo "Stopping Radarr"
    	systemctl stop radarr
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Radarr to /opt/backup"
	cp /opt/ProgramData/Radarr/.config/Radarr $backupdir
	tar -zcvf /opt/backup/Radarr_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Radarr"
	systemctl start radarr
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
