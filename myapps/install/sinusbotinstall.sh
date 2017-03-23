#!/bin/bash

sudo apt-get install -yqq debconf-utils lsb-release screen x11vnc xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less

sudo adduser --disabled-password --gecos "SinusBot" sinusbot

#Restoring SinusBot
#tar xf /home/xxxusernamexxx/install/sinusbot.tar
#cp -p -R /home/xxxusernamexxx/sinusbot /opt/
#chown sinusbot:sinusbot -R /opt/sinusbot
#chmod 755 -R /opt/sinusbot

cp -p -R /home/xxxusernamexxx/install/youtube-dl /usr/local/bin/

echo "Creating Sinusbot startup Script"
cp /home/xxxusernamexxx/install/Services/sinusbot.service /etc/systemd/system/
chmod 644 /etc/systemd/system/sinusbot.service
systemctl enable sinusbot.service
systemctl restart sinusbot.service
