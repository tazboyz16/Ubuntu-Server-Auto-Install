#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################


systemctl stop plexmediaserver
sleep 15
chmod 0777 -R /var/lib/plexmediaserver
sleep 25
mkdir -p /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Plug-ins

Programloc='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'

echo "Installing CouchPotato"
git clone https://github.com/mikedm139/CouchPotato.bundle.git "$Programloc"
#rm -r /opt/CouchPotato.bundle

echo "Installing Headphones"
git clone https://github.com/willpharaoh/headphones.bundle.git "$Programloc"
#rm -r /opt/headphones.bundle

echo "Installing SickBeard/SickRage"
git clone https://github.com/mikedm139/SickBeard.bundle.git "$Programloc"
#rm -r /opt/SickBeard.bundle

echo "Installing Speedtest"
git clone https://github.com/Twoure/Speedtest.bundle.git "$Programloc"
#rm -r /opt/Speedtest.bundle

echo "Installing SS-Plex"
git clone https://github.com/mikew/ss-plex.bundle.git "$Programloc"
#rm -r /opt/ss-plex.bundle

echo "Installing Sub Zero Subtitles"
git clone https://github.com/pannal/Sub-Zero.bundle.git "$Programloc"
#rm -r /opt/Sub-Zero.bundle

echo "Installing WebTools"
git clone https://github.com/ukdtom/WebTools.bundle.git "$Programloc"
#rm -r /opt/WebTools.bundle

chown plex:plex -R /var/lib/plexmediaserver
chmod 0777 -R /var/lib/plexmediaserver
systemctl start plexmediaserver
