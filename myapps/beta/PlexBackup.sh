#!/bin/bash

sudo systemctl stop plexmediaserver
cd /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/

sudo tar -cvpzf /media/SystemBackup/PlexBackup.tgz.bz2 *  

sudo systemctl start plexmediaserver
