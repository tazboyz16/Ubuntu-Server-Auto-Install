#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

exec &> /opt/install/Install.log

echo "<---Updating System....Please Wait..--->"
apt update; apt upgrade -y
apt install python2.7 git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2 python python-cheetah python-pyasn1 unrar-free openssl libssl-dev -y
echo "<--- Running Install Scripts --->" 
echo "<--- Installing iRedMail --->"; bash /opt/install/Iredmail/mailinstaller.sh
echo "<--- Installing Apache2 --->"; bash /opt/install/Apache2/Apache2-install.sh
echo "<--- Installing SSL Cert --->"; bash /opt/install/Apache2/Certbot.sh
echo "<--- Installing Mysql and Phpmyadmin --->"; bash /opt/install/Apache2/Mysql.sh
#echo "<--- Installing Noip --->"; bash /opt/install/Noip2/Noip2Install.sh
echo "<--- Installing Deluge --->"; bash /opt/install/Deluge/deluge_webui.sh
echo "<--- Installing CouchPotato --->"; bash /opt/install/couchpotato-installer.sh
echo "<--- Installing Headphones --->"; bash /opt/install/Headphones/headphones-installer.sh
echo "<--- Installing Mylar --->"; bash /opt/install/Mylar/mylar-installer.sh
echo "<--- Installing SickRage --->"; bash /opt/install/SickRage/sickrage-installer.sh
echo "<--- Installing Webmin --->"; bash /opt/install/Webmin/webmin-installer.sh
echo "<--- Installing Plex Media Server --->"; bash /opt/install/Plex/plexupdate.sh -p -a -d
echo "<--- Installing Plex Addon - OMBI --->"; bash  /opt/install/Plex/ombi.sh 
echo "<--- Installing Plex Addon - WebTools --->"; bash  /opt/install/Plex/Webtools.sh  
echo "<--- Installing Plex Addon - PlexPY --->"; bash  /opt/install/Plex/plexpy.sh 
echo "<--- Installing Emby Media Server --->"; bash /opt/install/EmbyServer/EmbyServerInstall.sh
echo "<--- Installing ZoneMinder --->"; bash /opt/install/Zoneminder/zminstall.sh
echo "<--- Installing TeamSpeak Server --->"; bash /opt/install/TeamSpeak3/ts3install.sh
echo "<--- Installing Sonarr --->"; bash /opt/install/Sonarr/sonarrinstall.sh
echo "<--- Installing Jackett --->"; bash /opt/install/Jackett/jackettinstall.sh
echo "<--- Installing Samba --->"; bash /opt/install/Samba/samba.sh
echo "<--- Installing Muximux --->"; bash /opt/install/Muximux/Muximuxinstall.sh
echo "<--- Installing HTPC-Manager --->"; bash /opt/install/HTPCManager/HTPCManager.sh
echo "<--- Installing LazyLibrarian --->"; bash /opt/install/Lazylibrarian/Lazylibrarian.sh
echo "<--- Installing Shinobi --->"; bash /opt/install/Shinobi/Shinobi.sh
echo "<--- Installing MadSonic --->"; bash /opt/install/Madsonic/MadSonic.sh
echo "<--- Installing Organizr --->"; bash /opt/install/Organizr/Organizr.sh
echo "<--- Installing Ubooquity --->"; bash /opt/install/Ubooquity/Ubooquity.sh
echo "<--- Installing SinusBot --->"; bash /opt/install/SinusBot/sinusbot.sh
echo "<--- Installing NZBget --->"; bash /opt/install/Nzbget/Nzbget.sh
echo "<--- Installing Nzbhydra --->"; bash /opt/install/Nzbhydra/Nzbhydra.sh

echo "<--- Installing Cron Jobs --->"; bash /opt/install/System/Cronjobs.sh
echo "<--- Restoring Fstab settings --->"; cat /opt/install/System/fstab.txt >> /etc/fstab
echo "<--- Disabling Install Services for Auto Installer --- >"; systemctl disable Installserver.service; systemctl mask Installserver.service
echo "<--- Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
