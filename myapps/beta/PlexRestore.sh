#!/bin/bash

sudo systemctl stop plexmediaserver
tar xjf /media/SystemBackup/PlexBackup.tgz.bz2
sudo chown xxxusernamexxx:xxxusernamexxx -R /var/lib/plexmediaserver/
sudo cp /home/xxxusernamexxx/PlexBackup /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server
sleep 20
sudo systemctl start plexmediaserver
