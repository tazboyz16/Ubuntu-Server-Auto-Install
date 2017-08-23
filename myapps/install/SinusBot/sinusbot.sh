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

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update 
mode="$1"

TeamSpeakClient=3.0.19.4
Programloc=/opt/Sinusbot
backupdir=/opt/backup/Sinusbot
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	apt install debconf-utils lsb-release screen x11vnc xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less python -y
	adduser --disabled-password --system --home /opt/ProgramData/Sinusbot --gecos "Sinusbot Service" --group sinusbot
	mkdir -p $Programloc
	cd $Programloc
	wget https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2
	tar -xjf sinusbot-beta.tar.bz2
	rm sinusbot-beta.tar.bz2
	#if new install
	cp config.ini.dist config.ini
	chown -R sinusbot:sinusbot $Programloc
	chmod 0777 -R $Programloc
	wget http://dl.4players.de/ts/releases/$TeamSpeakClient/TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	chmod 0755 TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	printf '\ny\n' | LESS='+q' ./TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	rm TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	wget https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
	chown -R sinusbot:sinusbot $Programloc
	chmod 0777 -R $Programloc
	echo "Fixing TS3 Client Location and Youtube-DL Location in Config"
	echo '
	ListenPort = 8087
    	ListenHost = "0.0.0.0"
    	TS3Path = "'$Programloc'/TeamSpeak3-Client-linux_amd64/ts3client_linux_amd64"
    	YoutubeDLPath = "/usr/local/bin/youtube-dl"' > $Programloc/config.ini
	echo "Creating Sinusbot startup Script"
	cp /opt/install/SinusBot/sinusbot.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/sinusbot.service
	systemctl enable sinusbot.service
	systemctl restart sinusbot.service
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0



	#Saved settings
	#cp /opt/install/SinusBot/config.ini /opt/Sinusbot/config.ini
