#!/bin/bash

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

apt get install python-letsencrypt-apache -y
mkdir /etc/letsencrypt/
mkdir /etc/apache2/ssl/
chmod 0777 -R /etc/letsencrypt/
chmod 0777 -R /etc/apache2/ssl/
mv /opt/install/Apache2/cli.ini /etc/letsencrypt/

letsencrypt --apache

letsencrypt renew --dry-run --agree-tos

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
