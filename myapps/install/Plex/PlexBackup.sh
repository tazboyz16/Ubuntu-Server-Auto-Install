#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

systemctl stop plexmediaserver
cd /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/

tar -cvpzf /opt/backup/PlexBackup.tgz.bz2 *  

systemctl start plexmediaserver
