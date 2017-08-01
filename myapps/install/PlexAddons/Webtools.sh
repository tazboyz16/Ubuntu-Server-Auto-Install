#!/bin/bash

systemctl stop plexmediaserver
sleep 15
chmod 0777 -R /var/lib/plexmediaserver
sleep 25
mkdir -p /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins

cd

echo "Installing CouchPotato"
git clone https://github.com/mikedm139/CouchPotato.bundle.git
cp -fR /opt/CouchPotato.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/CouchPotato.bundle

echo "Installing Headphones"
git clone https://github.com/willpharaoh/headphones.bundle.git
cp -fR /opt/headphones.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/headphones.bundle

echo "Installing SickBeard/SickRage"
git clone https://github.com/mikedm139/SickBeard.bundle.git
cp -fR /opt/SickBeard.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/SickBeard.bundle

echo "Installing Speedtest"
git clone https://github.com/Twoure/Speedtest.bundle.git
cp -fR /opt/Speedtest.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/Speedtest.bundle

echo "Installing SS-Plex"
git clone https://github.com/mikew/ss-plex.bundle.git
cp -fR /opt/ss-plex.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/ss-plex.bundle

echo "Installing Sub Zero Subtitles"
git clone https://github.com/pannal/Sub-Zero.bundle.git
cp -fR /opt/Sub-Zero.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/Sub-Zero.bundle

echo "Installing WebTools"
git clone https://github.com/ukdtom/WebTools.bundle.git
cp -fR /opt/WebTools.bundle /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins/
rm -r /opt/WebTools.bundle

chown plex:plex -R /var/lib/plexmediaserver
chmod 0777 -R /var/lib/plexmediaserver
systemctl start plexmediaserver
