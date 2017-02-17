#!/bin/bash

sudo systemctl stop plexmediaserver
tar xjf /media/SystemBackup/PlexBackup.tgz.bz2
sudo chown taz:taz -R /var/lib/plexmediaserver/
sudo cp /home/taz/PlexBackup /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server
sleep 20
sudo systemctl start plexmediaserver
