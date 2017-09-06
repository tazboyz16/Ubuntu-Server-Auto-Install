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

#Modes (Variables)
# w=(Weekly Updates) m=(Monthly Updates) a=(Update All)
mode="$1"






echo "Updating all Git Repos"; echo
echo "CouchPotato Auto Update"; sudo bash  /opt/install/CouchPotato/couchpotato-installer.sh -u; echo
echo "HTPCManger Auto Update"; sudo bash /opt/install/HTPCManager/HTPCManager.sh -u; echo
echo "HeadPhones Auto Update"; sudo bash /opt/install/Headphones/headphones-installer.sh -u; echo

#Disabled due to it installs by Releases vs git pull
#echo "Jackett Auto Update"; sudo bash /opt/install/Jackett/jackettinstall.sh -u; echo

echo "LazyLibrarian Auto Update"; sudo bash /opt/install/Lazylibrarian/Lazylibrarian.sh -u; echo
echo "Muximux Auto Update"; sudo bash /opt/install/Muximux/Muximuxinstall.sh -u; echo
echo "Mylar Auto Update"; sudo bash /opt/install/Mylar/mylar-installer.sh -u; echo
echo "Organizr Auto Update"; sudo bash /opt/install/Organizr/Organizr.sh -u; echo

#Disabled due to it installs by Releases vs git pull
#echo "Radarr Auto Update"; sudo bash /opt/install/Organizr/Organizr.sh -u; echo

echo "Shinobi Auto Update"; sudo bash /opt/install/Shinobi/Shinobi.sh -u; echo
echo "Sickrage Auto Update"; sudo bash /opt/install/Sickrage/sickrage-installer.sh -u; echo

echo "Grive Website backup"; cd /var/www; sudo grive; echo

echo "Plex Server Update"; sudo bash /opt/install/Plex/plexinstall.sh -u; echo
echo "Running System Security Updates"; unattended-upgrades -v






#Monthly Updates

domain=xxxDomainxxx

echo "Running SinusBot update"; sudo bash /opt/install/Sinusbot/sinusbot.sh -u; echo

echo "Update SSL Certs"
#run cron job for 'letsencrypt renew' every 90 days
#plus rewrite files to apache folder every run
certbot renew
cat /etc/letsencrypt/live/$domain/cert.pem > /etc/letsencrypt/live/$domain/apache.crt
cat /etc/letsencrypt/live/$domain/privkey.pem > /etc/letsencrypt/live/$domain/apache.key
cat /etc/letsencrypt/live/$domain/chain.pem > /etc/letsencrypt/live/$domain/apacheca.ca
cat /etc/letsencrypt/live/$domain/fullchain.pem > /etc/letsencrypt/live/$domain/apachecafull.ca
systemctl restart apache2
echo

echo "Running Full System Updates"; apt update; apt upgrade -y
