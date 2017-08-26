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
Programloc=/opt/Shinobi
backupdir=/opt/backup/Shinobi
time=$(date +"%m_%d_%y-%H_%M")

#Copied Ubuntu install file / will be replaced to support the InstallerConstants.sh
#mariadb or mysql-server
server=mysql-server
sqlpass=Z874HBVbD3augd2A

case $mode in
	(-i|"")
	apt update
	adduser --disabled-password --system --home /opt/ProgramData/Shinobi --gecos "Shinobi Service" --group Shinobi
	cd /opt &&  git clone https://github.com/moeiscool/Shinobi.git
	chown -R Shinobi:Shinobi /opt/Shinobi
	chmod -R 0777 /opt/Shinobi
	cd /opt/Shinobi
	apt-get update; apt install libav-tools ffmpeg -y
	echo "$server $server/root_password password $sqlpass" | debconf-set-selections
	echo "$server $server/root_password_again password $sqlpass" | debconf-set-selections
	apt install $server -y
	service mysql start
	update-rc.d mysql enable
	apt get install nodejs npm -y
	npm cache clean -f
	npm install -g n
	sudo n stable
	ln -s /usr/bin/nodejs /usr/bin/node
	chmod -R 0755 /opt/Shinobi
	mysql -u root -p$sqlpass -e "source sql/user.sql" || true
	mysql -u root -p$sqlpass -e "source sql/framework.sql" || true
	#adding Default user accounts
	mysql -u root -p$sqlpass --database ccio -e "source sql/default_data.sql" || true
	npm install
	npm install pm2 -g
	cp conf.sample.json conf.json
	cp super.sample.json super.json
	touch INSTALL/installed.txt
	echo "Creating Startup Script" 
	pm2 start camera.js
	pm2 start cron.js
	pm2 list
	pm2 startup
	pm2 save
	echo "Creating Symbolic link for Shinobi Service"
	ln -s /etc/systemd/system/pm2-root.service /etc/systemd/system/Shinobi.service
	;;
	(-r)
	echo "<--- Restoring Shinobi Settings --->"
	echo "Stopping Shinobi"
	systemctl stop Shinobi
	cat /opt/install/Shinobi/HTPCManager.txt > /opt/Shinobi/userdata
	chown -R Shinobi:Shinobi /opt/Shinobi
	chmod -R 0777 /opt/Shinobi
	echo "Starting up Shinobi"
	systemctl start Shinobi
	;;
	(-b)
	echo "Stopping Shinobi"
    	systemctl stop Shinobi
    	echo "Making sure Backup Dir exists"
    	mkdir -p $backupdir
    	echo "Backing up Shinobi to /opt/backup"
	cp -rf /opt/Shinobi/userdata $backupdir
    	tar -zcvf /opt/backup/Shinobi_FullBackup-$time.tar.gz $backupdir
    	echo "Restarting up Shinobi"
	systemctl start Shinobi
	;;
	(-u)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then 
		echo "Shinobi not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Shinobi to Update"
	sudo systemctl stop Shinobi
	sleep 5
	cd $Programloc
	git pull
	echo "Starting Shinobi"
	sudo systemctl start Shinobi
	;;
	(-U)
	#Checking if Program is installed
		if [ ! -d "$Programloc" ]; then
		echo "Shinobi not installed at '$Programloc'. Update Failed"
		exit 0;
		fi
	echo "Stopping Shinobi to Force Update"
	sudo systemctl stop Shinobi
	sleep 5
	cd $Programloc
	git fetch --all
	git reset --hard origin/master
	git pull
	echo "Starting Shinobi"
	sudo systemctl start Shinobi
	;;
    	(-*) echo "Invalid Argument"; exit 0;;
esac
exit 0
