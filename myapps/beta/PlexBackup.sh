#!/bin/bash

#/media/SystemBackup/ is my backup Flash Drive

sudo systemctl stop plexmediaserver
cd /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server
sudo tar -cvf PlexBackup.tgz.bz2 --exclude='./Metadata' --exclude='./Cache' --exclude='./Plugin\ Support' . /media/SystemBackup/ 

#  "/media/SystemBackup/PlexBackup.tgz.bz2" 
#   --exclude '/Plex\ Media\ Server/Cache/*' 
#   --exclude '/Plex\ Media\ Server/Plugin\ Support/*' 
#  /var/lib/plexmediaserver/Library/Application\ Support/


sudo systemctl start plexmediaserver
