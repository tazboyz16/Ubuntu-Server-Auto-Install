#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

apt update; apt install apache2 -y
sleep 15

echo "Enabling Mods to have Reverse Proxy to services"
a2enmod rewrite proxy proxy_http headers

echo "<--- Restoring Apache2 Settings --->"
cat /opt/install/Apache2/apache2.conf > /etc/apache2/apache2.conf
sleep 5
echo "<- Restoring Apache2 Error Pages ->"
cat /opt/install/Apache2/localized-error-pages.conf > /etc/apache2/conf-available/localized-error-pages.conf
systemctl restart apache2

echo "<--- Restoring WWW files for Website --->"
rm -rf /var/www
cd /opt/backup
tar xjf /opt/install/Apache2/www.tar.bz2
mv /opt/backup/www/ /var

echo
echo "<--- Changing Rights for dir WWW --->"
chmod 0777 -R /var/www
chown www-data:www-data -R /var/www
