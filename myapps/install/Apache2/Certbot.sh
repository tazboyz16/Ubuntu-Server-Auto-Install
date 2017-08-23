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

domain=xxxdomainxxx

#mysql install has SSL Certs made
#/etc/apache2/ssl/apache.crt
#/etc/apache2/ssl/apache.key
#your key file (mysite.com.key) will be privkey.pem
#your cert file (mysite.com.crt) will be cert.pem
#your ca file will be chain.pem or fullchain.pem ( depending exactly what you need )
#/etc/letsencrypt/archive and /etc/letsencrypt/keys contain all previous keys and certificates, while /etc/letsencrypt/live symlinks to the latest versions. or live /etc/letsencrypt/live/$domain

apt update
apt install software-properties-common -y
add-apt-repository -y ppa:certbot/certbot
apt update
apt install python-certbot-apache -y

mkdir /etc/letsencrypt/
mkdir /etc/apache2/ssl/
chmod 0777 -R /etc/letsencrypt/
chmod 0777 -R /etc/apache2/ssl/
cp /opt/install/Apache2/cli.ini /etc/letsencrypt/

certbot --apache

certbot renew --dry-run --agree-tos

echo "Convert Pem files to Crt,Key, and CA files"
cat /etc/letsencrypt/live/$domain/cert.pem > /etc/letsencrypt/live/$domain/apache.crt
cat /etc/letsencrypt/live/$domain/privkey.pem > /etc/letsencrypt/live/$domain/apache.key
cat /etc/letsencrypt/live/$domain/chain.pem > /etc/letsencrypt/live/$domain/apacheca.ca
cat /etc/letsencrypt/live/$domain/fullchain.pem > /etc/letsencrypt/live/$domain/apachecafull.ca

echo "Create Symlinks from apache to letsencrypt files"
ln -s /etc/letsencrypt/live/$domain/apache.crt /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/$domain/apache.key /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/$domain/apacheca.ca /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/$domain/apachecafull.ca /etc/apache2/ssl/

chmod 0777 -R /etc/letsencrypt/
chmod 0777 -R /etc/apache2/ssl/

###lines 32 and 33
sed -i '33s#/etc/ssl/private/ssl-cert-snakeoil.key#/etc/apache2/ssl/apache.key#g' /etc/apache2/sites-available/default-ssl.conf
sed -i '32s#/etc/ssl/certs/ssl-cert-snakeoil.pem#/etc/apache2/ssl/apache.crt#g' /etc/apache2/sites-available/default-ssl.conf
