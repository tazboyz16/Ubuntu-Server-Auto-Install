#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

#http://www.webupd8.org/2015/05/grive2-grive-fork-with-google-drive.html has the DEB File ftp link

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "<--- Installing Grive --->"
add-apt-repository -y ppa:nilarimogard/webupd8
echo "<-- Installing dependencies for Grive for Website Sync -->"
apt update; apt install grive -y
