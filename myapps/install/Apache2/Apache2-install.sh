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
# b=backup i=install r=restore 
mode="$1"
backupdir=/opt/backup/Apache

case $mode in
	(-i|"")
	apt update; apt install apache2 -y
	sleep 15
	echo "Enabling Mods to have Reverse Proxy to services"
	a2enmod rewrite proxy proxy_http headers
	echo "<--- Restoring Apache2 Settings --->"
	cat /opt/install/Apache2/apache2.conf > /etc/apache2/apache2.conf
	cat /opt/install/Apache2/000-default.conf > /etc/apache2/sites-available/000-default.conf
	echo "<- Restoring Apache2 Error Pages ->"
	cat /opt/install/Apache2/localized-error-pages.conf > /etc/apache2/conf-available/localized-error-pages.conf
	systemctl restart apache2
	;;
	(-r)
	echo "<--- Restoring WWW files for Website --->"
	echo "Stopping Apache2"
    	systemctl stop apache2
	cd /opt/backup
	tar -xvzf /opt/backup/Apache2_Backup.tar.gz
	rm -rf /var/www; mv /opt/backup/www/ /var
	rm -rf /etc/apache2/sites-available/000-default.conf; mv /opt/backup/000-default.conf /etc/apache2/sites-available/
	rm -rf /etc/apache2/apache2.conf; mv /opt/backup/apache2.conf /etc/apache2/
	rm -rf /etc/apache2/conf-available/localized-error-pages.conf; mv /opt/backup/localized-error-pages.conf /etc/apache2/conf-available/
	chmod 0777 -R /var/www
	chown www-data:www-data -R /var/www
	echo "Restarting up Apache2"
	systemctl restart apache2
	;;
	(-b)
	echo "Stopping Apache2"
    	systemctl stop apache2
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
	echo "Backing up Apache2 to /opt/backup"
	cp -rf /var/www/ $backupdir
	cp -rf /etc/apache2/sites-available/000-default.conf $backupdir
	cp -rf /etc/apache2/apache2.conf $backupdir
	cp -rf /etc/apache2/conf-available/localized-error-pages.conf $backupdir
	chmod 0777 -R $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Apache2_Backup.tar.gz *
	rm -rf $backupdir
	echo "Restarting up Apache2"
	systemctl start apache2
	;;
	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	exit 0;;
esac
exit 0
