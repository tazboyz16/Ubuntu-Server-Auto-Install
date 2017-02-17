#!/bin/bash

#Monthly Updates

echo "Running TS3 Server Update"
sudo systemctl stop ts3
sleep 5
sudo rsync -aP /media/SystemBackup/TS3-Update/ /opt/ts3
sleep 5
rm -r /media/SystemBackup/TS3-Update/*
chmod 0777 -R /opt/sinusbot
chown sinusbot -R /opt/sinusbot
sudo systemctl start ts3
echo "Done..."
echo

echo "Running SinusBot update"
sudo systemctl stop sinusbot
sleep 5
sudo rsync -aP /media/SystemBackup/Sinusbot-Update/ /opt/sinusbot
sleep 5
rm -r /media/SystemBackup/Sinusbot-Update/*
chmod 0777 -R /opt/sinusbot
chown sinusbot -R /opt/sinusbot
sudo systemctl start sinusbot
echo "Done..."
echo

echo "Update SSL Certs"
#run cron job for 'letsencrypt renew' every 90 days
#plus rewrite files to apache folder every run
letsencrypt renew 
cat /etc/letsencrypt/live/tazserver.noip.me/cert.pem > /etc/letsencrypt/live/tazserver.noip.me/apache.crt
cat /etc/letsencrypt/live/tazserver.noip.me/privkey.pem > /etc/letsencrypt/live/tazserver.noip.me/apache.key
cat /etc/letsencrypt/live/tazserver.noip.me/chain.pem > /etc/letsencrypt/live/tazserver.noip.me/apacheca.ca
cat /etc/letsencrypt/live/tazserver.noip.me/fullchain.pem > /etc/letsencrypt/live/tazserver.noip.me/apachecafull.ca
systemctl restart apache2
echo

echo "Running Full System Updates"
apt-get update
sleep 5
apt-get upgrade -yqq
