#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"

Programloc=/opt/Jackett
backupdir=/opt/backup/Jackett
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	adduser --disabled-password --system --home /opt/ProgramData/jackett --gecos "Jackett Service" --group jackett
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
	apt install mono-complete libcurl4-openssl-dev -y
	wget $(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep 'Jackett.Binaries.Mono.tar.gz' | cut -d\" -f4)
	tar -xvf Jackett.Binaries.Mono.tar.gz && sudo rm Jackett.Binaries.Mono.tar.gz
	mkdir /opt/Jackett
	mv Jackett/* /opt/Jackett
	chmod 0777 -R /opt/Jackett
	chown -R jackett:jackett /opt/Jackett
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
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Jackett/ServerConfig.json ~/.config/Jackett/
	echo "Restarting up Jackett"
	systemctl start jackett
	;;
	(-b)
	echo "Stopping Jackett"
    	systemctl stop jackett
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Jackett to /opt/backup"
	cp ~/.config/Jackett/ServerConfig.json $backupdir
	tar -zcvf /opt/backup/Jackett_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Jackett"
	systemctl start jackett
	;;
	(-u)
	echo "Stopping CouchPotato to Update"
	sudo systemctl stop couchpotato
	sleep 5
	cd $Programloc
	git pull
	echo "Starting CouchPotato"
	sudo systemctl start couchpotato
	;;
	(-U)
	echo "Stopping CouchPotato to Force Update"
	sudo systemctl stop couchpotato
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting CouchPotato"
	sudo systemctl start couchpotato
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
