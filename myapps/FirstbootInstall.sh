#!/bin/bash

echo "<---Updaing System....Please Wait..--->"
sudo apt-get update -qq
sudo apt-get upgrade -yqq

sudo apt-get install -yqq python2.7 mono-complete git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2 python python-cheetah python-pyasn1 unrar-free openssl libssl-dev

echo "<--- Running Install Scripts --->" 

#Web Programs
echo "<--- Installing iRedMail --->"
bash /home/taz/install/Iredmail/mailinstaller.sh

echo "<--- Installing Apache2 --->"
bash /home/taz/install/Apache2/Apache2-install.sh

echo "<--- Installing SSL Cert --->"
bash /home/taz/install/Apache2/Certbot.sh

echo "<--- Installing Mysql and Phpmyadmin --->"
bash /home/taz/install/Apache2/Mysql.sh

#DDNS
echo "<--- Installing Noip --->"
bash /home/taz/install/Noip2/Noip2Install.sh

#
echo "<--- Installing Deluge --->"
bash /home/taz/install/Deluge/deluge_webui.sh

echo "<--- Installing CouchPotato --->"
bash /home/taz/install/couchpotato-installer.sh

echo "<--- Installing Headphones --->"
bash /home/taz/install/Headphones/headphones-installer.sh

echo "<--- Installing Mylar --->"
bash /home/taz/install/Mylar/mylar-installer.sh

echo "<--- Installing SickRage --->"
bash /home/taz/install/SickRage/sickrage-installer.sh

echo "<--- Installing Webmin --->"
bash /home/taz/install/Webmin/webmin-installer.sh

echo "<--- Installing Plex Media Server --->"
bash /home/taz/install/Plex/plexinstall.sh

echo "<--- Installing Emby Media Server --->"
bash /home/taz/install/EmbyServer/EmbyServerInstall.sh

echo "<--- Installing Grive --->"
bash /home/taz/install/Grive/GriveInstaller.sh

echo "<--- Installing ZoneMinder --->"
bash /home/taz/install/Zoneminder/zminstall.sh

echo "<--- Installing TeamSpeak Server --->"
bash /home/taz/install/TeamSpeak3/ts3install.sh

echo "Installing Sonarr"
bash /home/taz/install/Sonarr/sonarrinstall.sh

echo "installing Jackett"
bash /home/taz/install/Jackett/jackettinstall.sh

echo "<--- Installing Samba --->"
bash /home/taz/install/Samba/samba.sh

echo "<--- Installing Kodi --->"
bash /home/taz/install/Kodi/Kodi-install.sh

echo "<--- Installing Muximux --->"
bash /home/taz/install/Muximux/Muximuxinstall.sh

echo "<--- Installing HTPC-Manager --->"
bash /home/taz/HTPCManager/HTPCManager.sh

echo "<--- Installing LazyLibrarian --->"
bash /home/taz/Lazylibrarian/Lazylibrarian.sh

echo "<--- Installing Shinobi --->"
bash /home/taz/Shinobi/Shinobi.sh

echo "<--- Installing MadSonic --->"
bash /home/taz/Madsonic/MadSonic.sh

echo "<--- Installing Organizr --->"
bash /home/taz/Organizr/Organizr.sh

echo "<--- Installing Ubooquity --->"
bash /home/taz/Organizr/Ubooquity.sh

#commented out due to TS3 client requires interaction for install
#echo "<--- Installing SinusBot --->"
#bash /home/taz/install/SinusBot/sinusbot.sh

echo "<-- Installing Cron Jobs -->"
bash /home/taz/install/System/Cronjobs.sh

#echo "<--- Restoring Fstab settings --->"
#cat /home/taz/install/System/fstab.txt >> /etc/fstab

echo "<---- Running Cleanup from Installs --->"
bash /home/taz/Cleanup.sh

echo "<-----Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
