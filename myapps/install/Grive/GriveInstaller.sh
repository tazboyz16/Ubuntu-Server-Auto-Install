#!/bin/bash

#http://www.webupd8.org/2015/05/grive2-grive-fork-with-google-drive.html has the DEB File ftp link

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "<--- Installing Grive --->"
add-apt-repository -y ppa:nilarimogard/webupd8
echo "<-- Installing dependencies for Grive for Website Sync -->"
apt get update; apt get install grive -y
