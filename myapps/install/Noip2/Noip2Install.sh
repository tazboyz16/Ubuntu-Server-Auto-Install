#!/bin/bash

echo noip2 noip2/forcenatoff select false | sudo /usr/bin/debconf-set-selections
echo noip2 noip2/matchlist select $1 | sudo /usr/bin/debconf-set-selections
echo noip2 noip2/netdevice select | sudo /usr/bin/debconf-set-selections
echo noip2 noip2/password select xxxpasswordxxx | sudo /usr/bin/debconf-set-selections
echo noip2 noip2/updating select 30 | sudo /usr/bin/debconf-set-selections
echo noip2 noip2/username select xxxusernamexxx | sudo /usr/bin/debconf-set-selections
dpkg -i /opt/install/Noip2/noip2_2.1.deb

echo "Creating Startup Script"
cp /opt/install/Noip2/noip2.service /etc/systemd/system/
chmod 644 /etc/systemd/system/noip2.service
systemctl enable noip2.service
systemctl restart noip2.service
