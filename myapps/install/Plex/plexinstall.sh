#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update
mode="$1"
Programloc=/var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/
backupdir=/opt/backup/Plex
time=$(date +"%m_%d_%y-%H_%M")

if ! source "/opt/install/Plex/plexupdate.sh"; then
	git clone https://github.com/mrworf/plexupdate.git /opt/install/Plex
fi

case $mode in
	(-i|"")
	echo "<--- Installing Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d
	;;
	(-b)
	echo "Backing up Plex Media Server"
	echo "<--- Stopping Plex Media Server ->"
	sudo systemctl stop plexmediaserver
	echo "Making sure Backup Dir exists"
	mkdir -p $backupdir
	echo "Backing up Plex Media Server to /opt/backup"
	cp $Programloc $backupdir
    	tar -zcvf /opt/backup/PlexMediaServer_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Plex Media Server"
	systemctl start plexmediaserver
	;;
	(-r)
	echo "<--- Restoring Plex Media Server ->"
	echo "<--- Stopping Plex Media Server ->"
	sudo systemctl stop plexmediaserver
	chmod 0777 -R $Programloc
	tar xjf $backupdir/PlexMediaServer_FullBackup-*.tar.gz $Programloc
	sleep 20
	echo "Restarting up Plex Media Server"
	systemctl start plexmediaserver
	;;
	(-u)
	echo "<--- Updating Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d
	;;
	(-U)
	echo "<--- Force Updating Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d -f
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
