#!/bin/bash

echo "<---Updaing System....Please Wait..--->"
sudo apt-get update -qq
sudo apt-get upgrade -yqq

sudo apt-get install -yqq python2.7 mono-complete git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2 python python-cheetah python-pyasn1 unrar-free openssl libssl-dev

echo "<--- Running Install Scripts --->" 

#Web Programs
echo "<--- Installing iRedMail --->"
bash /home/xxxusernamexxx/install/Iredmail/mailinstaller.sh

echo "<--- Installing Apache2 --->"
bash /home/xxxusernamexxx/install/Apache2/Apache2-install.sh

echo "<--- Installing SSL Cert --->"
bash /home/xxxusernamexxx/install/Apache2/Certbot.sh

echo "<--- Installing Mysql and Phpmyadmin --->"
bash /home/xxxusernamexxx/install/Apache2/Mysql.sh

#DDNS
echo "<--- Installing Noip --->"
bash /home/xxxusernamexxx/install/Noip2/Noip2Install.sh

#
echo "<--- Installing Deluge --->"
bash /home/xxxusernamexxx/install/Deluge/deluge_webui.sh

echo "<--- Installing CouchPotato --->"
bash /home/xxxusernamexxx/install/couchpotato-installer.sh

echo "<--- Installing Headphones --->"
bash /home/xxxusernamexxx/install/Headphones/headphones-installer.sh

echo "<--- Installing Mylar --->"
bash /home/xxxusernamexxx/install/Mylar/mylar-installer.sh

echo "<--- Installing SickRage --->"
bash /home/xxxusernamexxx/install/SickRage/sickrage-installer.sh

echo "<--- Installing Webmin --->"
bash /home/xxxusernamexxx/install/Webmin/webmin-installer.sh

echo "<--- Installing Plex Media Server --->"
bash /home/xxxusernamexxx/install/Plex/plexinstall.sh

echo "<--- Installing Emby Media Server --->"
bash /home/xxxusernamexxx/install/EmbyServer/EmbyServerInstall.sh

echo "<--- Installing Grive --->"
bash /home/xxxusernamexxx/install/Grive/GriveInstaller.sh

echo "<--- Installing ZoneMinder --->"
bash /home/xxxusernamexxx/install/Zoneminder/zminstall.sh

echo "<--- Installing TeamSpeak Server --->"
bash /home/xxxusernamexxx/install/TeamSpeak3/ts3install.sh

echo "Installing Sonarr"
bash /home/xxxusernamexxx/install/Sonarr/sonarrinstall.sh

echo "installing Jackett"
bash /home/xxxusernamexxx/install/Jackett/jackettinstall.sh

echo "<--- Installing Samba --->"
bash /home/xxxusernamexxx/install/Samba/samba.sh

echo "<--- Installing Kodi --->"
bash /home/xxxusernamexxx/install/Kodi/Kodi-install.sh

echo "<--- Installing Muximux --->"
bash /home/xxxusernamexxx/install/Muximux/Muximuxinstall.sh

echo "<--- Installing HTPC-Manager --->"
bash /home/xxxusernamexxx/HTPCManager/HTPCManager.sh

echo "<--- Installing LazyLibrarian --->"
bash /home/xxxusernamexxx/Lazylibrarian/Lazylibrarian.sh

echo "<--- Installing Shinobi --->"
bash /home/xxxusernamexxx/Shinobi/Shinobi.sh

echo "<--- Installing MadSonic --->"
bash /home/xxxusernamexxx/Madsonic/MadSonic.sh

echo "<--- Installing Organizr --->"
bash /home/xxxusernamexxx/Organizr/Organizr.sh

echo "<--- Installing Ubooquity --->"
bash /home/xxxusernamexxx/Organizr/Ubooquity.sh

#commented out due to TS3 client requires interaction for install
#echo "<--- Installing SinusBot --->"
#bash /home/xxxusernamexxx/install/SinusBot/sinusbot.sh

echo "<-- Installing Cron Jobs -->"
bash /home/xxxusernamexxx/install/System/Cronjobs.sh

#echo "<--- Restoring Fstab settings --->"
#cat /home/xxxusernamexxx/install/System/fstab.txt >> /etc/fstab

echo "<---- Running Cleanup from Installs --->"
bash /home/xxxusernamexxx/Cleanup.sh

echo "<-----Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
