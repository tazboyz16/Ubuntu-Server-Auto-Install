#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi
apt get install openjdk-8-jre -y

#Latest Stable as of 5/29/2017
#http://beta.madsonic.org/pages/download.jsp
wget http://madsonic.org/download/6.2/20161208_madsonic-6.2.9040.deb
dpkg -i 20161208_madsonic-6.2.9040.deb
