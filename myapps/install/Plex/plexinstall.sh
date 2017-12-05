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

#******1.7.5.4035-313f93718 version installs deb repo for Plex.tv self own repo to Sources.list******
#systemd file gets saved under /lib/systemd/system
#ignore cache folder, plug-ins folder,
#https://gist.github.com/ssmereka/8773626

#Modes (Variables)
# b=backup i=install r=restore u=update U=Force Update
mode="$1"
Programloc='/var/lib/plexmediaserver/Library/Application Support/Plex Media Server'
backupdir=/opt/backup/Plex

case $mode in
	(-i|"")
	echo "<--- Installing Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d
	#Checking if Iptables is installed and updating with port settings
	    if [ -f /etc/default/iptables ]; then
	        sed -i "s/#-A INPUT -p tcp --dport 32400 -j ACCEPT/-A INPUT -p tcp --dport 32400 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 1900 -j ACCEPT/-A INPUT -p tcp --dport 1900 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 3005 -j ACCEPT/-A INPUT -p tcp --dport 3005 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 5353 -j ACCEPT/-A INPUT -p tcp --dport 5353 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 8324 -j ACCEPT/-A INPUT -p tcp --dport 8324 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p tcp --dport 32469 -j ACCEPT/-A INPUT -p tcp --dport 32469 -j ACCEPT/g" /etc/default/iptables
		sed -i "s/#-A INPUT -p udp --match multiport --dport 32410,32412:32414 -j ACCEPT/-A INPUT -p udp --match multiport --dport 32410,32412:32414 -j ACCEPT/g" /etc/default/iptables
	        /etc/init.d/iptables restart
	   fi
	;;
	(-b)
	echo "Backing up Plex Media Server"
	echo "<--- Stopping Plex Media Server ->"
	sudo systemctl stop plexmediaserver
	echo "Making sure Backup Dir exists"
	mkdir -p $backupdir
	echo "Please Wait Checking Size of Plex Media Server to be backed up"
	echo "Once done total memory is on the bottom of list"
	du -h --max-depth=1 "$Programloc"
	sleep 5
	cd "$Programloc"
    	tar -cf /opt/backup/PlexMediaServer_Backup.tar.gz --lzma *
	rm -rf $backupdir
    	echo "Restarting up Plex Media Server"
	systemctl start plexmediaserver
	;;
	(-r)
	echo "<--- Restoring Plex Media Server ->"
	echo "<--- Stopping Plex Media Server ->"
	sudo systemctl stop plexmediaserver
	chmod 0777 -R "$Programloc"
	tar --lzma -xvf /opt/backup/PlexMediaServer_Backup.tar.gz -C "$Programloc"
	sleep 20
	echo "Restarting up Plex Media Server"
	systemctl start plexmediaserver
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Plex Media Server not installed at '$Programloc'. Update Failed"
		exit 0;
	fi
	echo "<--- Updating Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Plex Media Server not installed at '$Programloc'. Update Failed"
		exit 0;
	fi
	echo "<--- Force Updating Plex Media Server ->"
	bash /opt/install/Plex/plexupdate.sh -p -a -d -f
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
