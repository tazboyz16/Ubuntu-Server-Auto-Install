#!/bin/bash

echo "<---Updaing System....Please Wait..--->"
sudo apt-get update -qq
sudo apt-get upgrade -yqq

sudo apt-get install python2.7 mono-complete git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2

echo "<--- Running Install Scripts --->" 

echo "<--- Installing iRedMail --->"
bash /home/taz/install/mailinstaller.sh

echo "<--- Installing Apache2 --->"
bash /home/taz/install/Apache2-install.sh

echo "<--- Installing Mysql and Phpmyadmin --->"
bash /home/taz/install/Mysql.sh

echo "<--- Installing Noip --->"
bash /home/taz/install/Noip2Install.sh

echo "<--- Installing Deluge --->"
bash /home/taz/install/deluge_webui.sh

echo "<--- Installing CouchPotato --->"
bash /home/taz/install/couchpotato-installer.sh

echo "<--- Installing Headphones --->"
bash /home/taz/install/headphones-installer.sh

echo "<--- Installing Mylar --->"
bash /home/taz/install/mylar-installer.sh

echo "<--- Installing SickRage --->"
bash /home/taz/install/sickrage-installer.sh

echo "<--- Installing Webmin --->"
bash /home/taz/install/webmin-installer.sh

echo "<--- Installing Plex Media Server --->"
bash /home/taz/install/plexinstall.sh

echo "<--- Installing Emby Media Server --->"
bash /home/taz/install/EmbyServerInstall.sh

echo "<--- Installing Grive --->"
bash /home/taz/install/GriveInstaller.sh

echo "<--- Installing ZoneMinder --->"
bash /home/taz/install/zminstall.sh

echo "<--- Installing TeamSpeak Server --->"
bash /home/taz/install/ts3install.sh

echo "<--- Installing Sinusbot --->"
bash /home/taz/install/sinusbotinstall.sh

echo "<--- Installing Samba --->"
bash /home/taz/install/samba.sh

echo "<--- Installing Mybb for Website Forums --->"
bash /home/taz/install/Mybb.sh

echo "<-- Installing Cron Jobs -->"
bash /home/taz/install/Cronjobs.sh

#echo "<--- Restoring Fstab settings --->"
#cat /home/taz/install/configs/fstab.txt >> /etc/fstab

echo "<---- Running Cleanup from Installs --->"
bash /home/taz/Cleanup.sh

echo "<-----Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
