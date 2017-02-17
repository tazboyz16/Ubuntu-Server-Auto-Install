#!/bin/bash

echo "<---Updaing System....Please Wait..--->"
sudo apt-get update -qq
sudo apt-get upgrade -yqq

sudo apt-get install python2.7 mono-complete git-core python-lxml python-pip unzip libcurl4-openssl-dev bzip2

echo "<--- Running Install Scripts --->" 

echo "<--- Installing iRedMail --->"
bash /home/xxxusernamexxx/install/mailinstaller.sh

echo "<--- Installing Apache2 --->"
bash /home/xxxusernamexxx/install/Apache2-install.sh

echo "<--- Installing Mysql and Phpmyadmin --->"
bash /home/xxxusernamexxx/install/Mysql.sh

echo "<--- Installing Noip --->"
bash /home/xxxusernamexxx/install/Noip2Install.sh

echo "<--- Installing Deluge --->"
bash /home/xxxusernamexxx/install/deluge_webui.sh

echo "<--- Installing CouchPotato --->"
bash /home/xxxusernamexxx/install/couchpotato-installer.sh

echo "<--- Installing Headphones --->"
bash /home/xxxusernamexxx/install/headphones-installer.sh

echo "<--- Installing Mylar --->"
bash /home/xxxusernamexxx/install/mylar-installer.sh

echo "<--- Installing SickRage --->"
bash /home/xxxusernamexxx/install/sickrage-installer.sh

echo "<--- Installing Webmin --->"
bash /home/xxxusernamexxx/install/webmin-installer.sh

echo "<--- Installing Plex Media Server --->"
bash /home/xxxusernamexxx/install/plexinstall.sh

echo "<--- Installing Emby Media Server --->"
bash /home/xxxusernamexxx/install/EmbyServerInstall.sh

echo "<--- Installing Grive --->"
bash /home/xxxusernamexxx/install/GriveInstaller.sh

echo "<--- Installing ZoneMinder --->"
bash /home/xxxusernamexxx/install/zminstall.sh

echo "<--- Installing TeamSpeak Server --->"
bash /home/xxxusernamexxx/install/ts3install.sh

echo "<--- Installing Sinusbot --->"
bash /home/xxxusernamexxx/install/sinusbotinstall.sh

echo "<--- Installing Samba --->"
bash /home/xxxusernamexxx/install/samba.sh

echo "<--- Installing Mybb for Website Forums --->"
bash /home/xxxusernamexxx/install/Mybb.sh

echo "<-- Installing Cron Jobs -->"
bash /home/xxxusernamexxx/install/Cronjobs.sh

#echo "<--- Restoring Fstab settings --->"
#cat /home/xxxusernamexxx/install/configs/fstab.txt >> /etc/fstab

echo "<---- Running Cleanup from Installs --->"
bash /home/xxxusernamexxx/Cleanup.sh

echo "<-----Reboot is needed to take effect of All System Restores and Installs------>"
sleep 5
sudo reboot
