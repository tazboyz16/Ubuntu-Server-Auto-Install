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
# b=(backup) i=(install) r=(restore) vpn=(Split-tunneling with VPN-coming soon) dd=(setup default daemon to localhost/auto login to localhost GUI)

mode="$1"

Programloc=/var/lib/deluge
backupdir=/opt/backup/Deluge
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	## get packages required to build deluge ##
	echo "<--- Adding Deluge Team Dep Packages--->"
	add-apt-repository -y ppa:deluge-team/ppa
	apt update
	## setup deluge user
	echo "<--- Now we will setup a user for Deluge --->"
	adduser --disabled-password --system --home /opt/ProgramData/Deluge --gecos "Deluge service" --group Deluge
	sudo touch /var/log/deluged.log
	sudo touch /var/log/deluge-web.log
	sudo chown Deluge:Deluge /var/log/deluge*
	apt install python python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-libtorrent python-notify python-pygame python-glade2 librsvg2-common xdg-utils python-mako -y
	apt install deluged deluge-webui -y
	echo "Creating Startup Scripts For Deluged and Deluge-WebUI"
	cp /opt/install/Deluge/deluged.service /etc/systemd/system/
	cp /opt/install/Deluge/deluge-web.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/deluged.service
	chmod 644 /etc/systemd/system/deluge-web.service
	systemctl enable deluged.service
	systemctl enable deluge-web.service
	systemctl start deluged deluge-web
	;;
	(-r)
	echo "<--Restoring Deluge Settings -->"
	echo "Stopping Deluge"
	#defaults settings stored at /var/lib/deluge/.config/deluge
	#core.conf and web.conf
	#cp /opt/install/Deluge/core.conf /var/lib/deluge/.config/deluge
	#cp /opt/install/Deluge/web.conf /var/lib/deluge/.config/deluge
	systemctl stop deluged deluge-web
	sleep 15
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Deluge/core.conf $Programloc/.config/deluge
	cp /opt/install/Deluge/web.conf $Programloc/.config/deluge
	echo "Restarting up Deluge"
	systemctl start deluged deluge-web
	;;
	(-b)
	echo "Stopping Deluge"
    	systemctl stop deluged deluge-web
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Deluge to /opt/backup"
	cp $Programloc/.config/deluge/core.conf $backupdir
	cp $Programloc/.config/deluge/web.conf $backupdir
	tar -zcvf /opt/backup/Deluged_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Deluge"
	systemctl start deluged deluge-web
	;;
	(-vpn)
	#Is already setup in the 000-default.conf for Apache2 just need to finish the Split-tunneling with openvpn
	;;
	(-dd)
	echo "Stopping Deluge"
    	systemctl stop deluged deluge-web
	echo "Creating Auto load localhost WebUI for DelugeWeb"
	chmod 0777 -R /var/lib/deluge/
	sed -i 's#"default_daemon": ""#"default_daemon": "127.0.0.1:58846"#' $Programloc/.config/deluge/web.conf
	echo "Restarting up Deluge"
	systemctl start deluged deluge-web 
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
