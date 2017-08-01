#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

apt install debconf-utils lsb-release screen x11vnc xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less python -y
adduser --disabled-password --system --home /opt/ProgramData/Sinusbot --gecos "Sinusbot Service" --group sinusbot
mkdir -p /opt/Sinusbot
cd /opt/Sinusbot
wget https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2

tar -xjf sinusbot-beta.tar.bz2
#if new install
cp config.ini.dist config.ini
#Saved settings
#cp /opt/install/SinusBot/config.ini /opt/Sinusbot/config.ini

chown -R sinusbot:sinusbot /opt/Sinusbot
chmod 0777 -R /opt/Sinusbot

wget http://dl.4players.de/ts/releases/3.0.18.2/TeamSpeak3-Client-linux_amd64-3.0.18.2.run
chmod 0755 TeamSpeak3-Client-linux_amd64-3.0.18.2.run
printf '\ny\n' | LESS='+q' ./TeamSpeak3-Client-linux_amd64-3.0.18.2.run

wget https://yt-dl.org/downloads/latest/youtube-dl -o /opt/Sinusbot/youtube-dl
chmod a+rx /opt/Sinusbot/youtube-dl

cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins

chown -R sinusbot:sinusbot /opt/Sinusbot
chmod 0777 -R /opt/Sinusbot

echo "Creating Sinusbot startup Script"
cp /opt/install/SinusBot/sinusbot.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sinusbot.service
systemctl enable sinusbot.service
systemctl restart sinusbot.service
