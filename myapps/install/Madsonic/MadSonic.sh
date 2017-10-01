#!/bin/bash

###########################################################
# Created by @tazboyz16
# This Script was created at
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

#common locations for the files with Madsonic
#/var/madsonic, /usr/bin/madsonic, /usr/share/madsonic, /etc/default/madsonic,
#https://unix.stackexchange.com/questions/233468/how-does-systemd-use-etc-init-d-scripts


if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Modes (Variables)
# b=backup i=install r=restore u=update(coming soon)
mode="$1"
Programloc=/etc/default/madsonic
backupdir=/opt/backup/Madsonic

#grabing latest version number and its download page
mainversion=$(curl http://beta.madsonic.org/pages/download.jsp | grep -P -e "stable" | grep -Po -e "[\d]{1,3}.[\d]{1,3}.[\d]{1,6}" | cut -c1-3 | tr -d '.')
stableversion=$(curl http://beta.madsonic.org/pages/download.jsp | grep -P -e "stable" | grep -Po -e "[\d]{1,3}.[\d]{1,3}.[\d]{1,6}")
#http://beta.madsonic.org/pages/download62.jsp






version=$(curl http://beta.madsonic.org/pages/download.jsp | grep -P -e "stable" | grep -Po -e "[\d]{1,3}.[\d]{1,3}.[\d]{1,6}" | cut -c1-3 | tr -d '.')
echo $version
mainversion=$(curl http://beta.madsonic.org/pages/download.jsp | grep -P -e "stable" | grep -Po -e "[\d]{1,3}.[\d]{1,3}.[\d]{1,6}" | cut -c1-3)
echo $mainversion
stableversion=$(curl http://beta.madsonic.org/pages/download.jsp | grep -P -e "stable" | grep -Po -e "[\d]{1,3}.[\d]{1,3}.[\d]{1,6}")
echo $stableversion

dateversion=$(curl http://beta.madsonic.org/pages/download$version.jsp | grep -Pe "[\d]+_madsonic-6.2.9040.deb" | grep -Poe "request.jsp\?branch=6.2&target=[\d]+_madsonic-6.2.9040.deb" | grep -Poe "[\d]{8}")
echo $dateversion

wget http://madsonic.org/download/$mainversion/$dateversion\_madsonic-$stableversion.deb -O madsonic.deb

#madsonic.org/download/6.2/20161208_madsonic-6.2.9040.deb



beta.madsonic.org/pages/
wget http://beta.madsonic.org/pages/request.jsp?branch=$mainversion&target=*_madsonic-$stableversion.deb
case $mode in
	(-i|"")
	add-apt-repository -y ppa:webupd8team/java
	apt update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt install oracle-java8-installer -y
	adduser --disabled-password --system --home /opt/ProgramData/Madsonic --gecos "Madsonic Service" --group Madsonic
	wget http://madsonic.org/download/$miniversion/$MadSonicDeb
	dpkg -i $MadSonicDeb
	rm -rf $MadSonicDeb
	chmod 0777 -R /var/madsonic
	#Changing user account choice vs running as root
	service madsonic stop
	sed -i "s#MADSONIC_USER=root#MADSONIC_USER=Madsonic#" $Programloc
	echo "Creating Systemd Startup Script"
	cp /opt/install/Madsonic/madsonic.service /etc/systemd/system/
	service madsonic stop
	sudo killall madsonic
	sudo update-rc.d -f madsonic remove
	#sudo rm /etc/default/madsonic
	chmod 644 /etc/systemd/system/madsonic.service
	systemctl enable madsonic.service
	systemctl restart madsonic.service
	;;
	(-r)
	echo "<-- Restoring Madsonic Settings -->"
	echo "Stopping Madsonic"
	systemctl stop madsonic
	cd /opt/backup
	sudo chmod 0777 -R /var/madsonic
	tar -xvzf /opt/backup/Madsonic_Backup.tar.gz
	cp -rf /opt/backup/db /var/madsonic; rm -rf /opt/backup/db
	cp -rf madsonic.properties /var/madsonic; rm -rf madsonic.properties
	echo "Restarting up Madsonic"
	systemctl start madsonic
	;;
	(-b)
	echo "Stopping Madsonic"
    	systemctl stop madsonic
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Madsonic to /opt/backup"
	cp -rf /var/madsonic/db $backupdir
	cp -rf /var/madsonic/madsonic.properties $backupdir
	cd $backupdir
	tar -zcvf /opt/backup/Madsonic_Backup.tar.gz *
	rm -rf $backupdir
    	echo "Restarting up Madsonic"
	systemctl start madsonic
	;;
    	(-*) echo "Invalid Argument"
	echo "**Running install script without arguments will Run install**"
	echo "-b for Backup Settings"
	echo "-i for Install"
	echo "-r for Restore Settings"
	#echo "-u for Update"
	exit 0;;
esac
exit 0
