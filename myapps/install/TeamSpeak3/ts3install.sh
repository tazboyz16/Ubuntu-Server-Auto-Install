#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "Copying TeamSpeak3 files over to Opt folder"
tar xjf /home/xxxusernamexxx/install/TeamSpeak3/ts3.tar.bz2
cp -p -R /home/xxxusernamexxx/ts3 /opt/ 

echo "Setting up Mysql for TS3"
adduser --no-create-home --disabled-password --gecos "TeamSpeak Server" teamspeak
mysql_secure_instalation
mysql --user=root -pxxxpasswordxxx mysql -e "CREATE database teamspeak3"
mysql --user=root -pxxxpasswordxxx mysql -e "GRANT ALL PRIVILEGES on teamspeak3.* to teamspeak3@localhost identified by 'xxxpasswordxxx';"
ln -s /opt/ts3/redist/libmariadb.so.2 /opt/ts3/libmariadb.so.2
apt get install libmariadb2 -y

echo "Configuring Teamspeak"
touch /opt/ts3/query_ip_blacklist.txt
echo "127.0.0.1" > /opt/ts3/query_ip_whitelist.txt
cat /home/xxxusernamexxx/install/TeamSpeak3/ts3server.txt > /opt/ts3/ts3server.ini
cat /home/xxxusernamexxx/install/TeamSpeak3/ts3db_mariadb.txt > /opt/ts3/ts3db_mariadb.ini
chmod 0777 /opt/ts3 -R
chown teamspeak:teamspeak /opt/ts3 -R

echo "Creating Startup Script"
cp /home/xxxusernamexxx/install/TeamSpeak3/ts3.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ts3.service
systemctl enable ts3.service
systemctl restart ts3.service
