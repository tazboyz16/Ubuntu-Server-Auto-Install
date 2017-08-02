#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "<---Updating System....Please Wait..--->"
apt get update; apt get upgrade -y
apt install python2.7 mono-complete git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2 python python-cheetah python-pyasn1 unrar-free openssl libssl-dev -y
echo "<--- Running Install Scripts --->" 
echo "<--- Installing iRedMail --->"; bash /opt/install/Iredmail/mailinstaller.sh
echo "<--- Installing Apache2 --->"; bash /opt/install/Apache2/Apache2-install.sh
echo "<--- Installing SSL Cert --->"; bash /opt/install/Apache2/Certbot.sh
echo "<--- Installing Mysql and Phpmyadmin --->"; bash /opt/install/Apache2/Mysql.sh
echo "<--- Installing Noip --->"; bash /opt/install/Noip2/Noip2Install.sh
echo "<--- Installing Deluge --->"; bash /opt/install/Deluge/deluge_webui.sh
echo "<--- Installing CouchPotato --->"; bash /opt/install/couchpotato-installer.sh
echo "<--- Installing Headphones --->"; bash /opt/install/Headphones/headphones-installer.sh
echo "<--- Installing Mylar --->"; bash /opt/install/Mylar/mylar-installer.sh
echo "<--- Installing SickRage --->"; bash /opt/install/SickRage/sickrage-installer.sh
echo "<--- Installing Webmin --->"; bash /opt/install/Webmin/webmin-installer.sh
echo "<--- Installing Plex Media Server --->"; bash /opt/install/Plex/plexupdate.sh -p -a -d
echo "<--- Installing 3rd Party Plex Addons --->"; bash /opt/install/PlexAddons/PlexAddons.sh
echo "<--- Installing Emby Media Server --->"; bash /opt/install/EmbyServer/EmbyServerInstall.sh
echo "<--- Installing Grive --->"; bash /opt/install/Grive/GriveInstaller.sh
echo "<--- Installing ZoneMinder --->"; bash /opt/install/Zoneminder/zminstall.sh
echo "<--- Installing TeamSpeak Server --->"; bash /opt/install/TeamSpeak3/ts3install.sh
echo "<--- Installing Sonarr --->"; bash /opt/install/Sonarr/sonarrinstall.sh
echo "<--- Installing Jackett --->"; bash /opt/install/Jackett/jackettinstall.sh
echo "<--- Installing Samba --->"; bash /opt/install/Samba/samba.sh
echo "<--- Installing Kodi --->"; bash /opt/install/Kodi/Kodi-install.sh
echo "<--- Installing Muximux --->"; bash /opt/install/Muximux/Muximuxinstall.sh
echo "<--- Installing HTPC-Manager --->"; bash /opt/HTPCManager/HTPCManager.sh
echo "<--- Installing LazyLibrarian --->"; bash /opt/Lazylibrarian/Lazylibrarian.sh
echo "<--- Installing Shinobi --->"; bash /opt/Shinobi/Shinobi.sh
echo "<--- Installing MadSonic --->"; bash /opt/Madsonic/MadSonic.sh
echo "<--- Installing Organizr --->"; bash /opt/Organizr/Organizr.sh
echo "<--- Installing Ubooquity --->"; bash /opt/Organizr/Ubooquity.sh
echo "<--- Installing SinusBot --->"; bash /opt/install/SinusBot/sinusbot.sh
echo "<--- Installing NZBget --->"; bash /opt/install/Nzbget.sh
echo "<--- Installing Cron Jobs --->"; bash /opt/install/System/Cronjobs.sh
echo "<--- Restoring Fstab settings --->"; cat /opt/install/System/fstab.txt >> /etc/fstab
echo "<---- Running Cleanup from Installs --->"; bash /opt/Cleanup.sh
echo "<-----Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
