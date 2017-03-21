#!/bin/bash

sudo systemctl stop plexmediaserver
cd /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plugin\ Support/

sudo tar -cvf PlexBackup.tgz.bz2 * /media/SystemBackup/ 

sudo systemctl start plexmediaserver
