#!/bin/bash

systemctl stop plexmediaserver
cd
tar xjf /media/SystemBackup/PlexBackup.tgz.bz2
chown xxxusernamexxx:xxxusernamexxx -R /var/lib/plexmediaserver/
cp /home/xxxusernamexxx/PlexBackup /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plugin\ Support/
sleep 20
systemctl start plexmediaserver
