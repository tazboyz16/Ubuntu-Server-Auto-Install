#!/bin/bash

#mysql install has SSL Certs made
#/etc/apache2/ssl/apache.crt
#/etc/apache2/ssl/apache.key
#your key file (mysite.com.key) will be privkey.pem
#your cert file (mysite.com.crt) will be cert.pem
#your ca file will be chain.pem or fullchain.pem ( depending exactly what you need )

#/etc/letsencrypt/archive and /etc/letsencrypt/keys contain all previous keys and certificates, while /etc/letsencrypt/live symlinks to the latest versions. or live /etc/letsencrypt/live/$domain

sudo apt-get install -yqq python-letsencrypt-apache
mkdir /etc/letsencrypt/
chmod 0777 -R /etc/letsencrypt/
chmod 0777 -R /etc/apache2/ssl/
mv /home/taz/install/configs/cli.ini /etc/letsencrypt/

letsencrypt --apache

letsencrypt renew --dry-run --agree-tos

echo "Convert Pem files to Crt,Key, and CA files"
cat /etc/letsencrypt/live/xxxdomainxxx/cert.pem > /etc/letsencrypt/live/xxxdomainxxx/apache.crt
cat /etc/letsencrypt/live/xxxdomainxxx/privkey.pem > /etc/letsencrypt/live/xxxdomainxxx/apache.key
cat /etc/letsencrypt/live/xxxdomainxxx/chain.pem > /etc/letsencrypt/live/xxxdomainxxx/apacheca.ca
cat /etc/letsencrypt/live/xxxdomainxxx/fullchain.pem > /etc/letsencrypt/live/xxxdomainxxx/apachecafull.ca

echo "Create Symlinks from apache to letsencrypt files"
ln -s /etc/letsencrypt/live/xxxdomainxxx/apache.crt /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/xxxdomainxxx/apache.key /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/xxxdomainxxx/apacheca.ca /etc/apache2/ssl/
ln -s /etc/letsencrypt/live/xxxdomainxxx/apachecafull.ca /etc/apache2/ssl/

chmod 0777 -R /etc/letsencrypt/
chmod 0777 -R /etc/apache2/ssl/
