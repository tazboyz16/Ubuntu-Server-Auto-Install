#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

Programloc=/opt/CouchPotatoServer/
backupdir=/opt/backup/CouchPotatoServer
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt install git-core python python-cheetah python-pyasn1 python3-lxml -y
	adduser --disabled-password --system --home /opt/ProgramData/couchpotato --gecos "CouchPotato Service" --group couchpotato
	echo "<--- Downloading latest CouchPotato --->"
	cd /opt && sudo git clone https://github.com/CouchPotato/CouchPotatoServer.git
	chown -R couchpotato:couchpotato $Programloc
	chmod -R 0777 $Programloc
	echo "Creating Startup Script"
	cp /opt/install/CouchPotato/couchpotato.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/couchpotato.service
	systemctl enable couchpotato.service
	systemctl restart couchpotato.service 
	;;
	(-r)
	echo "<--- Restoring CouchPotato Settings --->"
	chmod -R 0777 /opt/ProgramData/couchpotato
	cp /opt/install/CouchPotato/CouchPotato.txt /opt/ProgramData/couchpotato/.couchpotato/settings.conf
	;;
	(-b)
	echo "Stopping CouchPotato"
    	systemctl stop couchpotato
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up CouchPotato to /opt/backup"
	cp /opt/ProgramData/couchpotato/.couchpotato/settings.conf $backupdir
	# Data Folder might be located under /root/.couchpotato/ if theres a Data Folder created  
	cp /opt/CouchPotatoServer/Data $backupdir
    	tar -zcvf /opt/backup/CouchPotato_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up CouchPotato"
	systemctl start couchpotato
	;;
	(-u)
	echo "Stopping CouchPotato to Update"
	sudo systemctl stop Couchpotato
	sleep 5
	cd $Programloc
	git pull
	sudo systemctl start Couchpotato
	;;
	(-U)
	echo "Stopping CouchPotato to Force Update"
	sudo systemctl stop Couchpotato
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	sudo systemctl start Couchpotato
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
