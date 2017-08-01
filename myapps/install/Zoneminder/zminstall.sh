#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

add-apt-repository -y ppa:iconnor/zoneminder
apt get update 

#mariadb or mysql for the server
server=mysql-server
sqlpass=xxxpasswordxxx
zmsqlpass=xxxpasswordxxx

echo $server $server/root_password password $sqlpass | debconf-set-selections
echo $server $server/root_password_again password $sqlpass | debconf-set-selections

apt install zoneminder php7.0-gd $server -y
mysql --user=root -p$sqlpass mysql -e "grant select,insert,update,delete,create,alter,index,lock tables on zm.* to 'zmadmin'@localhost identified by '$zmsqlpass';"
mysql --user=root -p$sqlpass -h localhost zm  < /usr/share/zoneminder/db/zm_create.sql
systemctl enable zoneminder
a2enconf zoneminder
a2enmod cgi
chown -R www-data:www-data /usr/share/zoneminder/
a2enmod rewrite
chown www-data:www-data /etc/zm/zm.conf
cat /opt/install/Zoneminder/php.ini > /etc/php/7.0/apache2/php.ini
service apache2 reload

cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
echo "sql_mode=NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.cnf

systemctl restart apache2
systemctl restart zoneminder

#Change DB username and password and make changes in files
#/usr/share/zoneminder/www/api/app/Config/database.php - might not need to be updated for it looks like it uses the zm config for the values
#/etc/zm/zm.conf change values of ZM_DB_USER and ZM_DB_PASS to new values

echo "Restoring Settings for ZoneMinder"
cat /opt/install/Zoneminder/database.php > /usr/share/zoneminder/www/api/app/Config/database.php
cat /opt/install/Zoneminder/zm.conf > /etc/zm/zm.conf

echo "Enabling Force all to HTTPS Connections"
cp /opt/install/Zoneminder/.htaccess /usr/share/zoneminder/www/
chown -R www-data:www-data /usr/share/zoneminder/

echo "Creating Startup Script"
systemctl enable zoneminder.service
systemctl restart zoneminder.service
