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

echo "Reseting Sinusbot Service back to normal operations"
 sytemctl stop sinusbot
sed -i 's/ -pwreset=foobar/ /g' /etc/systemd/system/sinusbot.service
systemctl daemon-reload
systemctl restart sinusbot
