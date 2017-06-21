#!/bin/bash

sudo apt-get install -yqq debconf-utils lsb-release screen x11vnc xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less

sudo adduser --disabled-password --system --home /opt/ProgramData/sinusbot --gecos "Sinusbot Service" --group sinusbot

mkdir -p /opt/sinusbot
cd /opt/sinusbot
wget https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2

tar -xjf sinusbot-beta.tar.bz2

#if new install
cp config.ini.dist config.ini
sed -i "s/TS3Path = .*/TS3Path = /opt/sinusbot/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64" /opt/sinusbot/config.ini
sed -i "s/YoutubeDLPath = .*/YoutubeDLPath = /usr/local/bin/youtube-dl" /opt/sinusbot/config.ini
sed -i "s/SSLKeyFile = .*/SSLKeyFile = /etc/apache2/ssl/apache.key" /opt/sinusbot/config.ini
sed -i "s/SSLCertFile = .*/SSLCertFile = "/etc/apache2/ssl/apache.crt" /opt/sinusbot/config.ini


#Saved settings
#cp /home/xxxusernamexxx/install/SinusBot/config.ini /opt/sinusbot/config.ini

chown -R sinusbot:sinusbot /opt/sinusbot
chmod 0755 -R /opt/sinusbot

wget http://dl.4players.de/ts/releases/3.0.18.2/TeamSpeak3-Client-linux_amd64-3.0.18.2.run
chmod 0755 TeamSpeak3-Client-linux_amd64-3.0.18.2.run
./TeamSpeak3-Client-linux_amd64-3.0.18.2.run

cp -p -R /home/xxxusernamexxx/install/SinusBot/youtube-dl /usr/local/bin/
cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
cd
chown -R sinusbot:sinusbot /opt/sinusbot
chmod 0755 -R /opt/sinusbot

./sinusbot --pwreset=xxxpasswordxxx

echo "Creating Sinusbot startup Script"
cp /home/xxxusernamexxx/install/SinusBot/sinusbot.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sinusbot.service
systemctl enable sinusbot.service
systemctl restart sinusbot.service
