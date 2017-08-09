#!/bin/bash

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
time=$(date +"%m_%d_%y-%H_%M")

case $mode in
	(-i|"")
	add-apt-repository -y ppa:webupd8team/java
	apt update
	echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
	echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
	apt install oracle-java8-installer -y
	adduser --disabled-password --system --home /opt/ProgramData/Madsonic --gecos "Madsonic Service" --group Madsonic
	#Latest Stable as of 5/29/2017
	#http://beta.madsonic.org/pages/download.jsp
	wget http://madsonic.org/download/6.2/20161208_madsonic-6.2.9040.deb
	dpkg -i 20161208_madsonic-6.2.9040.deb
	echo "Creating Systemd Startup Script"
	cp /opt/install/Madsonic/madsonic.service /etc/systemd/system/
	#edit MADSONIC_USER variable to not run as root under /etc/default/madsonic for port number change
	#also /var/lib/madsonic/madsonic.properties for auto-generated settings file
	sed -i "s#Madsonic_user=root#Madsonic_user=Madsonic#" /etc/default/madsonic
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
	sudo chmod 0777 -R $Programloc
	cp /opt/install/Madsonic/ServerConfig.json ~/.config/Jackett/
	echo "Restarting up Madsonic"
	systemctl start madsonic
	;;
	(-b)
	echo "Stopping Madsonic"
    	systemctl stop madsonic
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Madsonic to /opt/backup"
	cp /var/lib/madsonic/db $backupdir
	cp /var/lib/madsonic/madsonic.properties $backupdir
	tar -zcvf /opt/backup/Madsonic_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Madsonic"
	systemctl start madsonic
	;;
	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
	
	
	
