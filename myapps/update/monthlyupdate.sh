#!/bin/bash


###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

#Monthly Updates

domain=xxxDomainxxx

echo "Running SinusBot update"
sudo systemctl stop sinusbot
sleep 5
cd /opt/sinusbot
wget https://www.sinusbot.com/dl/sinus-beta.tar.bz2
tar -xjvf sinusbot-beta.tar.bz2
cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
cd
chmod 0777 -R /opt/sinusbot
chown sinusbot -R /opt/sinusbot
sudo systemctl start sinusbot
echo "Done..."
echo

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

echo "Running Full System Updates"
apt update
sleep 5
apt upgrade -y
