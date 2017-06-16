#!/bin/bash

systemctl stop plexmediaserver
sleep 15
sudo chmod 0777 -R /var/lib/plexmediaserver
sleep 25
sudo mkdir -p /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins

cd

echo "Installing CouchPotato"
sudo git clone https://github.com/mikedm139/CouchPotato.bundle.git
cp -fR /home/xxxusernamexxx/CouchPotato.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/CouchPotato.bundle

echo "Installing Headphones"
sudo git clone https://github.com/willpharaoh/headphones.bundle.git
cp -fR /home/xxxusernamexxx/headphones.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/headphones.bundle

echo "Installing SickBeard/SickRage"
sudo git clone https://github.com/mikedm139/SickBeard.bundle.git
cp -fR /home/xxxusernamexxx/SickBeard.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/SickBeard.bundle

echo "Installing Speedtest"
sudo git clone https://github.com/Twoure/Speedtest.bundle.git
cp -fR /home/xxxusernamexxx/Speedtest.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/Speedtest.bundle

echo "Installing SS-Plex"
sudo git clone https://github.com/mikew/ss-plex.bundle.git
cp -fR /home/xxxusernamexxx/ss-plex.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/ss-plex.bundle

echo "Installing Sub Zero Subtitles"
sudo git clone https://github.com/pannal/Sub-Zero.bundle.git
cp -fR /home/xxxusernamexxx/Sub-Zero.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/Sub-Zero.bundle

echo "Installing WebTools"
sudo git clone https://github.com/ukdtom/WebTools.bundle.git
cp -fR /home/xxxusernamexxx/WebTools.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /home/xxxusernamexxx/WebTools.bundle

chown plex:plex -R /var/lib/plexmediaserver
sudo chmod 0777 -R /var/lib/plexmediaserver
systemctl start plexmediaserver
