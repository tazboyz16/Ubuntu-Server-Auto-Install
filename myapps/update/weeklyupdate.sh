#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

echo "Updating all Git Repos"
echo

echo "CouchPotato Auto Update"
sudo bash  /opt/install/CouchPotato/couchpotato-installer.sh -u
echo

echo "HTPCManger Auto Update"
sudo bash /opt/install/HTPCManager/HTPCManager.sh -u
echo

echo "HeadPhones Auto Update"
sudo bash /opt/install/Headphones/headphones-installer.sh -u
echo

#Disabled due to it installs by Releases vs git pull
#echo "Jackett Auto Update"
#sudo bash /opt/install/Jackett/jackettinstall.sh -u
#echo

echo "LazyLibrarian Auto Update"
sudo bash /opt/install/Lazylibrarian/Lazylibrarian.sh -u
echo

echo "Muximux Auto Update"
sudo bash /opt/install/Muximux/Muximuxinstall.sh -u
echo

echo "Mylar Auto Update"
sudo bash /opt/install/Mylar/mylar-installer.sh -u
echo

echo "Organizr Auto Update"
sudo bash /opt/install/Organizr/Organizr.sh -u
echo

#Disabled due to it installs by Releases vs git pull
#echo "Radarr Auto Update"
#sudo bash /opt/install/Organizr/Organizr.sh -u
#echo

echo "Shinobi Auto Update"
sudo bash /opt/install/Shinobi/Shinobi.sh -u
echo

echo "Sickrage Auto Update"
sudo bash /opt/install/Sickrage/sickrage-installer.sh -u
echo

echo "Grive Website backup" 
cd /var/www
sudo grive 
echo

echo "Plex Server Update"
sudo bash /opt/install/Plex/plexinstall.sh -u 
echo

echo "Running System Security Updates"
unattended-upgrades -v
