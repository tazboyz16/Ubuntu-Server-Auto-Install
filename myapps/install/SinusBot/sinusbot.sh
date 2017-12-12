#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update passwd=(Remove the Forced Foobarr password)
mode="$1"

TeamSpeakClient=3.1.6
Programloc=/opt/Sinusbot
backupdir=/opt/backup/Sinusbot

case $mode in
	(-i|"")
	apt install debconf-utils lsb-release screen x11vnc xvfb libxcursor1 ca-certificates bzip2 psmisc libglib2.0-0 less python libnss3 libegl1-mesa x11-xkb-utils libasound2 -y
	adduser --disabled-password --system --home /opt/ProgramData/Sinusbot --gecos "Sinusbot Service" --group sinusbot
	wget https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2 -P $Programloc/
	cd $Programloc/
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
	wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
	    if [ -f TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so ]; then
	    rm TeamSpeak3-Client-linux_amd64/xcbglintegrations/libqxcb-glx-integration.so
	    fi
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
	#Checking if Iptables is installed and updating with CP port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 8087 -j ACCEPT/-A INPUT -p tcp --dport 8087 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-r)
	echo "<--- Restoring Sinusbot Settings --->"
	echo "Stopping Sinusbot"
	systemctl stop sinusbot
	cd /opt/backup
	tar -xvzf /opt/backup/Sinusbot_Backup.tar.gz
	cp -rf config.ini $Programloc; rm -rf config.ini
	cp -rf data/ $Programloc; rm -rf data/
	chown -R sinusbot:sinusbot $Programloc
	chmod -R 0777 $Programloc
	echo "Starting up Sinusbot"
	systemctl start sinusbot
	;;
	(-b)
	#Saved settings
	#cp /opt/install/SinusBot/config.ini /opt/Sinusbot/config.ini
	#and cp /data folder
	echo "Stopping Sinusbot"
    	systemctl stop sinusbot
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Sinusbot to /opt/backup"
	cp -rf /opt/Sinusbot/config.ini $backupdir
	cp -rf /opt/Sinusbot/data $backupdir
	cd $backupdir
    	tar -zcvf /opt/backup/Sinusbot_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Sinusbot"
	systemctl start sinusbot
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Sinusbot not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Performing Backup of SinusBot Dir"
	bash /opt/install/SinusBot/sinusbot.sh -b
	
	echo "Updating SinusBot"
	systemctl stop sinusbot
	cd $Programloc
	wget https://www.sinusbot.com/dl/sinusbot-beta.tar.bz2
	tar -xjf sinusbot-beta.tar.bz2
	rm sinusbot-beta.tar.bz2
	chown -R sinusbot:sinusbot $Programloc
	chmod 0777 -R $Programloc
	wget http://dl.4players.de/ts/releases/$TeamSpeakClient/TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	chmod 0755 TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	printf '\ny\n' | LESS='+q' ./TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	rm TeamSpeak3-Client-linux_amd64-$TeamSpeakClient.run
	wget https://yt-dl.org/downloads/latest/youtube-dl -O /usr/local/bin/youtube-dl
	chmod a+rx /usr/local/bin/youtube-dl
	cp plugin/libsoundbot_plugin.so TeamSpeak3-Client-linux_amd64/plugins
	chown -R sinusbot:sinusbot $Programloc
	chmod 0777 -R $Programloc
	systemctl restart sinusbot.service
	;;
	(-passwd)
	echo "Reseting Sinusbot Service back to normal operations"
 	systemctl stop sinusbot
	sed -i 's/ -pwreset=foobar/ /g' /etc/systemd/system/sinusbot.service
	systemctl daemon-reload
	systemctl restart sinusbot
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	echo "-u for Update"
	echo "-passwd for Return back to normal settings vs force foobar for password"
	exit 0;;
esac
exit 0
