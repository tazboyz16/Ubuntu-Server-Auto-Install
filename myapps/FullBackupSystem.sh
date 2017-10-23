#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

time=$(date +"%m_%d_%y-%H_%M")


if [ -d /etc/apache2 ]; then
bash /opt/install/Apache2/Apache2-install.sh -b
else
echo "Apache2 is not installed. No Backup Require"
fi
echo

if [ -d /opt/CouchPotato ]; then
bash /opt/install/CouchPotato/couchpotato-installer.sh -b
else
echo "CouchPotato is not installed. No Backup Require"
fi
echo

if [ -d /var/lib/deluge ]; then
bash /opt/install/Deluge/deluge_webui.sh -b
else
echo "Deluge is not installed. No Backup Require"
fi
echo

if [ -d /usr/lib/emby-server ]; then
bash /opt/install/EmbyServer/EmbyServerInstall.sh -b
else
echo "Emby Server is not installed. No Backup Require"
fi
echo

if [ -d /opt/HTPCManager ]; then
bash /opt/install/HTPCManager/HTPCManager.sh -b
else
echo "HTPCManager is not installed. No Backup Require"
fi
echo

if [ -d /opt/Headphones ]; then
bash /opt/install/Headphones/headphones-installer.sh -b
else
echo "Headphones is not installed. No Backup Require"
fi
echo

# iRedMail Backup option once installer is fully setup
#if [ -d /opt/mail ]; then
#bash /opt/install/Iredmail/mailinstaller.sh -b
#else
#echo "Iredmail is not installed. No Backup Require"
#fi
#echo

if [ -d /opt/Jackett ]; then
bash /opt/install/Jackett/jackettinstall.sh -b
else
echo "Jackett is not installed. No Backup Require"
fi
echo

if [ -d /opt/LazyLibrarian ]; then
bash /opt/install/Lazylibrarian/Lazylibrarian.sh -b
else
echo "LazyLibrarian is not installed. No Backup Require"
fi
echo

if [ -d /etc/default/madsonic ]; then
bash /opt/install/MadSonic/MadSonic.sh -b
else
echo "MadSonic is not installed. No Backup Require"
fi
echo

if [ -d ~/.config/mopidy/ ]; then
bash /opt/install/Mopidy/Mopidyinstall.sh -b
else
echo "Mopidy is not installed. No Backup Require"
fi
echo

if [ -d /opt/Muximux ]; then
bash /opt/install/Muximux/Muximuxinstall.sh -b
else
echo "Muximux is not installed. No Backup Require"
fi
echo

if [ -d /opt/Mylar ]; then
bash /opt/install/Mylar/mylar-installer.sh -b
else
echo "Mylar is not installed. No Backup Require"
fi
echo







 


if [ -d /opt/HTPCManager ]; then
bash /opt/install/HTPCManager/HTPCManager.sh -b
else
echo "HTPCManager is not installed. No Backup Require"
fi
echo

