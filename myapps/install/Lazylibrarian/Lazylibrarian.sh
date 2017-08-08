#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"

Programloc=/opt/LazyLibrarian
backupdir=/opt/backup/LazyLibrarian
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt update
	apt install python
	adduser --disabled-password --system --home /opt/ProgramData/LazyLibrarian --gecos "LazyLibrarian Service" --group LazyLibrarian
   	cd /opt &&  git clone https://github.com/DobyTang/LazyLibrarian.git
   	chown -R LazyLibrarian:LazyLibrarian /opt/LazyLibrarian
   	chmod -R 0777 /opt/LazyLibrarian
  	echo "Creating Startup Script" 
   	cp /opt/install/Lazylibrarian/LazyLibrarian.service /etc/systemd/system/
   	chmod 644 /etc/systemd/system/LazyLibrarian.service
   	systemctl enable LazyLibrarian.service
   	systemctl restart LazyLibrarian.service
   	;;
   	(-r)
	echo "<--Restoring LazyLibrarian Settings -->"
	echo "Stopping LazyLibrarian"
	systemctl stop LazyLibrarian
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Jackett/ServerConfig.json $Programloc/config.ini
	echo "Restarting up LazyLibrarian"
	systemctl start LazyLibrarian
	;;
	(-b)
	echo "Stopping LazyLibrarian"
    	systemctl stop LazyLibrarian
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
	#config file will not show up till after making any changes to settings
    	echo "Backing up LazyLibrarian to /opt/backup"
	cp $Programloc/config.ini $backupdir
	tar -zcvf /opt/backup/LazyLibrarian_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up LazyLibrarian"
	systemctl start LazyLibrarian
	;;
	(-u)
	echo "Stopping LazyLibrarian to Update"
	sudo systemctl stop LazyLibrarian
	sleep 5
	cd $Programloc
	git pull
	echo "Starting LazyLibrarian"
	sudo systemctl start LazyLibrarian
	;;
	(-U)
	echo "Stopping LazyLibrarian to Force Update"
	sudo systemctl stop LazyLibrarian
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting LazyLibrarian"
	sudo systemctl start LazyLibrarian
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
