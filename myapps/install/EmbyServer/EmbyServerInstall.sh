#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

#As of 8/3/2017 Emby only has 12.04 14.04 16.04 16.10 17.04 and Next versions of ubuntu

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

version=$(lsb_release -rs)
versionm=$(lsb_release -cs)
#Modes (Variables)
# b=backup i=install r=restore 
mode="$1"
Programloc=/usr/lib/emby-server
backupdir=/opt/backup/EmbyServer
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	echo "<--- Adding Emby to Repository --->"
	sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/emby/xUbuntu_$version/ /' > /etc/apt/sources.list.d/emby-server.list"
	#Emby Repo
	apt-key adv --fetch-keys http://download.opensuse.org/repositories/home:emby/xUbuntu_$version/Release.key
	#Mono
	apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
	echo "deb http://download.mono-project.com/repo/ubuntu $versionm main" | sudo tee /etc/apt/sources.list.d/mono-offical.list
	echo "<--- Installing Emby Server --->"
	apt update
	apt install mono-complete mono-devel -y
	apt install emby-server -y
	systemctl enable emby-server
	echo "<--- Finished Installing Emby Server --->"
	;;
	(-r)
	echo "<--Restoring Emby Server Settings -->"
	echo "Stopping Emby Server"
	systemctl stop emby-server
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Jackett/ServerConfig.json /var/lib/emby-server/config/
	echo "Restarting up Emby Server"
	systemctl start emby-server
	;;
	(-b)
	echo "Stopping Emby Server"
    	systemctl stop emby-server
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Emby Server to /opt/backup"
	cp /var/lib/emby-server/config/system.xml $backupdir
	tar -zcvf /opt/backup/EmbyServer_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Emby Server"
	systemctl start emby-server
	;;
	(-f)
	#only run if getting a libembysqlite3.so.0 error
	#create symlinks for in x86 for libembysqlite3.so.0 in bin/etc/and root folder of emby
	ln -s /usr/lib/emby-server/x86_64-linux-gnu/libembysqlite3.so.0 /usr/lib/emby-server/
	ln -s /usr/lib/emby-server/x86_64-linux-gnu/libembysqlite3.so.0 /usr/lib/emby-server/bin
	ln -s /usr/lib/emby-server/x86_64-linux-gnu/libembysqlite3.so.0 /usr/lib/emby-server/etc
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
