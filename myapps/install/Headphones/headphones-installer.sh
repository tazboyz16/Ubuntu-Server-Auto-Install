#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

Programloc=/opt/headphones
backupdir=/opt/backup/headphones
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt install python git-core -y
	adduser --disabled-password --system --home /opt/ProgramData/headphones --gecos "Headphones Service" --group headphones
	echo '<--- Downloading latest Headphones --->'
	cd /opt &&  git clone https://github.com/rembo10/headphones.git
	chown -R headphones:headphones /opt/headphones
	chmod -R 0777 /opt/headphones
	echo "Creating Startup Script"
	cp /opt/install/Headphones/headphones.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/headphones.service
	systemctl enable headphones.service
	systemctl restart headphones.service
	;;
	(-r)
	echo "<--- Restoring Headphones Settings --->"
	echo "Stopping Headphones"
	systemctl stop headphones
	cat /opt/install/Headphones/Headphones.txt > /opt/headphones/config.ini
	chown -R headphones:headphones /opt/headphones
	chmod -R 0777 /opt/headphones
	echo "Starting up Headphones"
	systemctl start headphones
	;;
	(-b)
	echo "Stopping Headphhones"
    	systemctl stop headphones
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up CouchPotato to /opt/backup"
	cp /opt/headphones/config.ini $backupdir
	echo "Data Folder might be located under $Programloc if theres a Data Folder created"
	echo "some install dont have it"
	cp $Programloc/Data $backupdir
    	tar -zcvf /opt/backup/Headphones_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Headphhones"
	systemctl start headphones
	;;
	(-u)
	echo "Stopping Headphhones to Update"
	sudo systemctl stop headphones
	sleep 5
	cd $Programloc
	git pull
	echo "Starting Headphhones"
	sudo systemctl start headphones
	;;
	(-U)
	echo "Stopping Headphhones to Force Update"
	sudo systemctl stop headphones
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting Headphhones"
	sudo systemctl start headphones
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
