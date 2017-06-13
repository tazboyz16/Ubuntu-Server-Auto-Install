#!/bin/bash

echo mysql-server mysql-server/root_password password xxxpasswordxxx | debconf-set-selections
echo mysql-server mysql-server/root_password_again password xxxpasswordxxx | debconf-set-selections
echo phpmyadmin phpmyadmin/dbconfig-install boolean true | debconf-set-selections
echo phpmyadmin phpmyadmin/app-password-confirm password xxxpasswordxxx | deconf-set-selections
echo phpmyadmin phpmyadmin/mysql/admin-pass password xxxpasswordxxx | deconf-set-selections
echo phpmyadmin phpmyadmin/mysql/app-pass password xxxpasswordxxx | debconf-set-selections
echo phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2 | debconf-set-selections

echo "<--- Installing Mysql and Phpmyadmin --->"
apt-get -yqq install mysql-server phpmyadmin

echo "<--- Installing PHP packages --->"
apt-get -yqq install php7.0 apache2 php7.0-mbstring libapache2-mod-php7.0 php7.0-curl php7.0-gd php7.0-mcrypt php7.0-mysql php7.0-* php-gettext
#not needed program
apt-get remove php7.0-snmp -yy

echo "<--- Configuring Settings on Website Packages --->"
a2enmod rewrite
sed -i "s/AllowOverride None/AllowOverride All/g" /etc/apache2/apache2.conf
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/apache2/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/apache2/php.ini

echo -e "<--- Configure Apache to use phpmyadmin --->"
#echo -e "\n\nServerName localhost\n" >> /etc/apache2/apache2.conf

a2enconf phpmyadmin

echo -e "<--- Restarting Apache --->"
systemctl restart apache2

echo "<--- Securing PHP MyAdmin --->"
sed -i "8s/.*/AllowOverride All/g" /etc/apache2/conf-available/phpmyadmin.conf

systemctl restart apache2

echo "<--- Creating htaccess file --->"
echo -e "RewriteEngine On" >> /usr/share/phpmyadmin/.htaccess
echo -e "RewriteCond %{HTTPS} off" >> /usr/share/phpmyadmin/.htaccess
echo -e "RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}" >> /usr/share/phpmyadmin/.htaccess
echo -e "AuthType Basic" >> /usr/share/phpmyadmin/.htaccess
echo -e 'AuthName "Restricted Files"' >> /usr/share/phpmyadmin/.htaccess
echo -e "AuthUserFile /etc/phpmyadmin/.htpasswd" >> /usr/share/phpmyadmin/.htaccess
echo -e "Require valid-user" >> /usr/share/phpmyadmin/.htaccess

echo "<--- Creating Second login file --->"
apt-get install -yqq apache2-utils

#Have to type in user password for Config
# to add more users sudo htpasswd /etc/phpmyadmin/.htpasswd username
echo
echo "<--- Enter Password for Second Login Screen to Access PhpmyAdmin --->"
htpasswd -b -c /etc/phpmyadmin/.htpasswd xxxusernamexxx xxxpasswordxxx

systemctl restart apache2 

echo "<--- Setting up SSL Connections with PHPMyAdmin --->"

a2enmod ssl
systemctl restart apache2 

echo "< ---Creating SSL Certificate ---> "
mkdir /etc/apache2/ssl

#Run Certbot.sh and Create Symbolinks to Certbot Certs for they renew 90 days
sudo bash /home/xxxusernamexxx/install/Apache2/Certbot.sh

###lines 32 and 33
sed -i '33s#/etc/ssl/private/ssl-cert-snakeoil.key#/etc/apache2/ssl/apache.key#g' /etc/apache2/sites-available/default-ssl.conf
sed -i '32s#/etc/ssl/certs/ssl-cert-snakeoil.pem#/etc/apache2/ssl/apache.crt#g' /etc/apache2/sites-available/default-ssl.conf
echo -e '$cfg["ForceSSL"] = true;' | sudo tee -a /etc/phpmyadmin/config.inc.php

a2ensite default-ssl.conf
echo "<--- Restarting Apache2 Finalizing all Settings --->"
systemctl restart apache2
echo

#Need to create mysql user other then Root for use
echo "Creating Admin User for mysql use with Phpmyadmin"
sudo mysql --user=root -pxxxpasswordxxx mysql -e "CREATE USER 'xxxusernamexxx'@'localhost' IDENTIFIED BY 'xxxpasswordxxx';"
sudo mysql --user=root -pxxxpasswordxxx mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'xxxusernamexxx'@'localhost' WITH GRANT OPTION;"

