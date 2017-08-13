#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

versionm=$(lsb_release -cs)

#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"
Programloc=/opt/Radarr
backupdir=/opt/backup/Radarr
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
	apt update 
	apt install libmono-cil-dev curl mediainfo mono-devel -y
	adduser --disabled-password --system --home /opt/ProgramData/radarr --gecos "Radarr Service" --group radarr
	echo "<--- Downloading latest Radarr --->"
	cd /opt 
	wget $( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )
	tar -xvzf Radarr.develop.*.linux.tar.gz
	rm -rf Radarr*.tar.gz
	chown -R radarr:radarr /opt/Radarr/
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
	cp /opt/install/Radarr/ServerConfig.json ~/.config/Jackett/
	echo "Restarting up Radarr"
	systemctl start radarr
	;;
	(-b)
	echo "Stopping Radarr"
    	systemctl stop radarr
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Radarr to /opt/backup"
	cp ~/.config/Radarr/ServerConfig.json $backupdir
	tar -zcvf /opt/backup/Radarr_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Radarr"
	systemctl start radarr
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
