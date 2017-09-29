#! /bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

#ts3server_2017-08-23__04_21_02.*_0.log
#ts3server_2017-08-23__04_21_02.*_1.log - shows the Token entry - Admin login token
#http://media.teamspeak.com/ts3_literature/TeamSpeak%203%20Server%20Quick%20Start.txt



if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

#if theres issues with install, install mysql-server

#Modes (Variables)
# b=backup i=install ri=reinstall r=restore u=update U=Force Update 
mode="$1"
server=/opt/ts3
backupdir=/opt/backup/ts3
dl=/tmp
BK=$(cat $server/version)

#System Specs
arch=$(uname -m)
if [ "$arch" == "x86_64" ]; then
    arch="amd64"
else
    arch="x86"
fi

wget -q https://www.teamspeak.com/downloads --output-document=$dl/Temp
Version=$(grep -Pom 1 "server_linux_$arch-\K.*?(?=\.tar\.bz)" $dl/Temp)
rm $dl/Temp
if [ "$Version" == "" ]; then
    echo "Failed to get Current version!"
    exit
fi


case $mode in
    	(-i|"")
    	echo "Creating Teamspeak User account"
	adduser --no-create-home --disabled-password --gecos "TeamSpeak Server" teamspeak
	apt install libmariadb2
	echo "Downloading Latest Version of TeamSpeak 3 Server"
	wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
	echo "Installing TS3 Server Version $Version"
	mkdir $server
	tar -xjf $dl/package.tar.bz2 -C $dl/
	cp -rf $dl/teamspeak3-server_linux_$arch/* $server
	rm $dl/package.tar.bz2
	rm -rf $dl/teamspeak3-server_linux_$arch
	ln -s /opt/ts3/redist/libmariadb.so.2 /opt/ts3/libmariadb.so.2
	touch /opt/ts3/query_ip_blacklist.txt
	echo "127.0.0.1" > /opt/ts3/query_ip_whitelist.txt
	cat /opt/install/TeamSpeak3/ts3server.txt > /opt/ts3/ts3server.ini
	cat /opt/install/TeamSpeak3/ts3db_mariadb.txt > /opt/ts3/ts3db_mariadb.ini
	chmod 0777 -R /opt/ts3
	chown teamspeak:teamspeak -R /opt/ts3
	echo "Creating Startup Script"
	cp /opt/install/TeamSpeak3/ts3.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/ts3.service
	systemctl enable ts3.service
	systemctl restart ts3.service
    	;;
	(-b)
	echo "Stopping TS3 Server"
	systemctl stop ts3
	echo "Making sure Backup Dir exists"
 	mkdir -p /opt/backup
	echo "Backing up TS3 Folder to /opt/backup"
	cd $server
	tar -zcvf /opt/backup/ts3_Backup.tar.gz *
	echo "Restarting up Server"
	systemctl start ts3
	;;
	(-r) 
    	echo "Stopping TS3 Server"
	systemctl stop ts3
	rm -rf /opt/ts3/*	
	tar -xvzf /opt/backup/ts3_Backup.tar.gz -C $server
	echo "Starting TS3 Server"
	systemctl start ts3
	;;
    (-ri) 
   	echo "Stopping TS3 Server"
	systemctl stop ts3
	echo "1) 'Clean' Install"
	echo "2) 'Reinstall' over Current Installation"
	read rianswer
    	case $rianswer in
        	Clean)
        	rm -rf $server
        	echo "Creating Teamspeak User account"
		adduser --no-create-home --disabled-password --gecos "TeamSpeak Server" teamspeak
		echo "Downloading Latest Version of TeamSpeak 3 Server"
		wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
		echo "Installing TS3 Server Version $Version"
		tar -xjf $dl/package.tar.bz2 -C $dl/
		mv $dl/teamspeak3-server_linux_$arch/* $server
		rm $dl/package.tar.bz2
		ln -s /opt/ts3/redist/libmariadb.so.2 /opt/ts3/libmariadb.so.2
		touch /opt/ts3/query_ip_blacklist.txt
		echo "127.0.0.1" > /opt/ts3/query_ip_whitelist.txt
		cat /opt/install/TeamSpeak3/ts3server.txt > /opt/ts3/ts3server.ini
		cat /opt/install/TeamSpeak3/ts3db_mariadb.txt > /opt/ts3/ts3db_mariadb.ini
		chmod 0777 /opt/ts3 -R
		chown teamspeak:teamspeak /opt/ts3 -R
		echo "Creating Startup Script"
		cp /opt/install/TeamSpeak3/ts3.service /etc/systemd/system/
		chmod 644 /etc/systemd/system/ts3.service
		systemctl enable ts3.service
		systemctl restart ts3.service
        	exit 0;;
        	Reinstall)
        	echo "Stopping TS3 Server"
		systemctl stop ts3
		echo "Running Backup of Settings and DB of TeamSpeak Server Before Update"
		cp $server/query_ip_blacklist.txt $backupdir
		cp $server/query_ip_whitelist.txt $backupdir
		cp $server/ts3server.ini $backupdir
		cp $server/ts3db_mariadb.ini $backupdir
		cp $server/ts3server.sqlitedb $backupdir
		echo "Downloading Latest Version of TeamSpeak 3 Server"
		wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
		echo "Installing TS3 Server Version $Version"
		tar -xjf $dl/package.tar.bz2 -C $dl/
		cp -rf $dl/teamspeak3-server_linux_$arch/* $server
		rm $dl/package.tar.bz2
		echo "Moving back Settings and DB back to TS3 Folder"
		mv $backupdir/query_ip_blacklist.txt $server
		mv $backupdir/query_ip_whitelist.txt $server
		mv $backupdir/ts3server.ini $server
		mv $backupdir/ts3db_mariadb.ini $server
		mv $backupdir/ts3server.sqlitedb $server
		echo $Version > $server/version
		echo "Starting Updated Server"
		systemctl start ts3
  	      	exit 0;;
    		esac
		echo "Starting TS3 Server"
		systemctl start ts3 
		;;
    (-u) 
    if [ "$BK" == "$Version" ]; then
    	echo "Server is up to date! Latest Version is $Version. If you want to still install over Installation"
    	echo "Run Script with '-U' to Force Update"
    	exit 0
	fi
	echo "Stopping TS3 Server"
	systemctl stop ts3
	echo "Running Backup of Settings and DB of TeamSpeak Server Before Update"
	cp $server/query_ip_blacklist.txt $backupdir
	cp $server/query_ip_whitelist.txt $backupdir
	cp $server/ts3server.ini $backupdir
	cp $server/ts3db_mariadb.ini $backupdir
	cp $server/ts3server.sqlitedb $backupdir
	echo "Downloading Latest Version of TeamSpeak 3 Server"
	wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
	echo "Installing TS3 Server Version $Version"
	tar -xjf $dl/package.tar.bz2 -C $dl/
	cp -rf $dl/teamspeak3-server_linux_$arch/* $server
	rm $dl/package.tar.bz2
	echo "Moving back Settings and DB back to TS3 Folder"
	mv $backupdir/query_ip_blacklist.txt $server
	mv $backupdir/query_ip_whitelist.txt $server
	mv $backupdir/ts3server.ini $server
	mv $backupdir/ts3db_mariadb.ini $server
	mv $backupdir/ts3server.sqlitedb $server
	echo $Version > $server/version
	echo "Starting Updated Server"
	systemctl start ts3
	;;
    (-U) 
    	echo "Stopping TS3 Server"
	systemctl stop ts3
	echo "Running Backup of Settings and DB of TeamSpeak Server Before Update"
	cp $server/query_ip_blacklist.txt $backupdir
	cp $server/query_ip_whitelist.txt $backupdir
	cp $server/ts3server.ini $backupdir
	cp $server/ts3db_mariadb.ini $backupdir
	cp $server/ts3server.sqlitedb $backupdir
	echo "Downloading Latest Version of TeamSpeak 3 Server"
	wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
	echo "Installing TS3 Server Version $Version"
	tar -xjf $dl/package.tar.bz2 -C $dl/
	cp -rf $dl/teamspeak3-server_linux_$arch/* $server
	rm $dl/package.tar.bz2
	echo "Moving back Settings and DB back to TS3 Folder"
	mv $backupdir/query_ip_blacklist.txt $server
	mv $backupdir/query_ip_whitelist.txt $server
	mv $backupdir/ts3server.ini $server
	mv $backupdir/ts3db_mariadb.ini $server
	mv $backupdir/ts3server.sqlitedb $server
	echo $Version > $server/version
	echo "Starting Updated Server"
	systemctl start ts3
  	;;
  	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	echo "-u for Update"
	echo "-U for Force Update"
	exit 0;;
esac
exit 0
