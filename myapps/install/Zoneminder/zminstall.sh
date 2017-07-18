#!/bin/bash

sudo add-apt-repository -y ppa:iconnor/zoneminder
sudo apt-get update -qq

echo mysql-server mysql-server/root_password password xxxpasswordxxx | debconf-set-selections
echo mysql-server mysql-server/root_password_again password xxxpasswordxxx | debconf-set-selections

sudo apt install zoneminder php7.0-gd -y
sudo mysql --user=root -pxxxpasswordxxx mysql -e "grant select,insert,update,delete,create,alter,index,lock tables on zm.* to 'zmadmin'@localhost identified by 'xxxpasswordxxx';"
sudo mysql --user=root -pxxxpasswordxxx -h localhost zm  < /usr/share/zoneminder/db/zm_create.sql
sudo systemctl enable zoneminder
sudo a2enconf zoneminder
sudo a2enmod cgi
sudo chown -R www-data:www-data /usr/share/zoneminder/
sudo a2enmod rewrite
sudo chown www-data:www-data /etc/zm/zm.conf
sudo cat /opt/install/Zoneminder/php.ini > /etc/php/7.0/apache2/php.ini
sudo service apache2 reload

sudo cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf
echo "sql_mode=NO_ENGINE_SUBSTITUTION" >> /etc/mysql/mysql.cnf

sudo systemctl restart apache2
sudo systemctl restart zoneminder

#Change DB username and password and make changes in files
#/usr/share/zoneminder/www/api/app/Config/database.php - might not need to be updated for it looks like it uses the zm config for the values
#/etc/zm/zm.conf change values of ZM_DB_USER and ZM_DB_PASS to new values

echo "Restoring Settings for ZoneMinder"
sudo cat /opt/install/Zoneminder/database.php > /usr/share/zoneminder/www/api/app/Config/database.php
sudo cat /opt/install/Zoneminder/zm.conf > /etc/zm/zm.conf

echo "Enabling Force all to HTTPS Connections"
sudo cp /opt/install/Zoneminder/.htaccess /usr/share/zoneminder/www/
sudo chown -R www-data:www-data /usr/share/zoneminder/

echo "Creating Startup Script"
systemctl enable zoneminder.service
systemctl restart zoneminder.service
