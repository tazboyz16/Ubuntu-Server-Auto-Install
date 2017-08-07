#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update
mode="$1"
Programloc=/var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/
backupdir=/opt/backup/Plex
time=$(date +"%m_%d_%y-%H_%M")

if ! source "${SCRIPT_PATH}/plexupdate.sh"; then
	git clone https://github.com/mrworf/plexupdate.git /opt/install/Plex
fi

case $mode in
	(-i|"")
	echo "<--- Installing Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d
	;;
	(-b)
	echo "<--- Backing up Plex Media Server ->"
	
	;;
	(-r)
	echo "<--- Restoring Plex Media Server ->"
	
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
