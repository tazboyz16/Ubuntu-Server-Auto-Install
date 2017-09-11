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
# b=(backup) i=(install) r=(restore) vpn=(Split-tunneling with VPN-coming soon)

mode="$1"

Programloc=/opt/Deluge
backupdir=/opt/backup/Deluge
versionm=$(lsb_release -cs)

case $mode in
	(-i|"")
	## get packages required to build deluge ##
	echo "<--- Adding Deluge Team Dep Packages--->"
	add-apt-repository -y ppa:deluge-team/ppa
	apt update
	## setup deluge user
	echo "<--- Now we will setup a user for Deluge --->"
	adduser --disabled-password --system --home /opt/Deluge --gecos "Deluge service" --group Deluge
	sudo touch /var/log/deluged.log
	sudo touch /var/log/deluge-web.log
	sudo chown Deluge:Deluge /var/log/deluge*
	apt install python python-twisted python-openssl python-setuptools intltool python-xdg python-chardet geoip-database python-libtorrent python-notify python-pygame python-glade2 librsvg2-common xdg-utils python-mako -y
	apt install deluge deluged deluge-webui deluge-console -y
	chmod 0777 -R $Programloc
	echo "Creating Startup Scripts For Deluged and Deluge-WebUI"
	cp /opt/install/Deluge/deluged.service /etc/systemd/system/
	cp /opt/install/Deluge/deluge-web.service /etc/systemd/system/
	chmod 644 /etc/systemd/system/deluged.service
	chmod 644 /etc/systemd/system/deluge-web.service
	systemctl enable deluged.service
	systemctl enable deluge-web.service
	systemctl start deluged deluge-web
	sleep 5
	echo "Stopping Deluge"
    	systemctl stop deluged deluge-web
	echo "Creating Auto load localhost WebUI for DelugeWeb"
	chmod 0777 -R $Programloc
	sed -i 's#"default_daemon": ""#"default_daemon": "127.0.0.1:58846"#' $Programloc/.config/deluge/web.conf
	echo "Restarting up Deluge"
	systemctl start deluged deluge-web 
	;;
	(-r)
	echo "<--Restoring Deluge Settings -->"
	echo "Stopping Deluge"
	systemctl stop deluged deluge-web
	cd /opt/backup
	tar -xvzf /opt/backup/Deluged_Backup.tar.gz
	sudo chmod 0777 -R $Programloc
	cp core.conf $Programloc/.config/deluge; rm core.conf
	cp web.conf $Programloc/.config/deluge; rm web.conf
	echo "Restarting up Deluge"
	systemctl start deluged deluge-web
	;;
	(-b)
	#defaults settings stored at User home dir that runs Deluge process
	#Primary setting files core.conf and web.conf
	echo "Stopping Deluge"
    	systemctl stop deluged deluge-web
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Deluge to /opt/backup"
	chmod 0777 -R $Programloc
	cp -rf $Programloc/.config/deluge/core.conf $backupdir
	cp -rf $Programloc/.config/deluge/web.conf $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Deluged_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Deluge"
	systemctl start deluged deluge-web
	;;
	(-vpn)
	#Is already setup in the 000-default.conf for Apache2 just need to finish the Split-tunneling with openvpn
	echo "Adding OpenVPN Repositories for Latest Verison"
	wget -O - https://swupdate.openvpn.net/repos/repo-public.gpg|apt-key add -
	echo "deb http://build.openvpn.net/debian/openvpn/stable $versionm main" > /etc/apt/sources.list.d/openvpn-aptrepo.list
	apt update; apt install openvpn -y
	#https://www.htpcguides.com/force-torrent-traffic-vpn-split-tunnel-debian-8-ubuntu-16-04/
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
	echo "deb https://repo.windscribe.com/ubuntu $versionm main" > /etc/apt/sources.list.d/windscribe-repo.list
	apt update; apt install windscribe-cli -y
	windscribe login
	windscribe firewall off
	windscribe connect best     #This command will auto connect to windscribe service
	sleep 5 #allowing creation of openvpn config file to be created
	windscribe disconnect
	echo "
	auth-nocache
	route-noexec" >> /etc/windscribe/client.ovpn
	#up and down scripts to be executed when VPN starts or stops
	#up /etc/openvpn/iptables.sh
	#down /etc/openvpn/update-resolv-con
	
	####
	##windscribe --help
	### its under beta
	#requires openvpn installed
	#https://forum.htpcguides.com/Thread-VPN-Split-Tunneling-problem
	# /etc/windscribe has the client.ovpn file
	#windscribe has a update-resolv-conf in /etc/windscribe
	# when turned on according to ^ interface 'tun' is active
	#windscribe connect best
	#windscribe connect US
	#windscribe firewall on/off/auto
	#windscribe protocol TCP/UDP def is UDP
	
	#DNS Server 1 208.67.222.222
	#DNS Server 2 208.67.222.220
	#Change 3 option in Resolv to Google DNS
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
