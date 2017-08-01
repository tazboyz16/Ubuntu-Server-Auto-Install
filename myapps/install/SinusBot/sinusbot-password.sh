#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

echo "Reseting Sinusbot Service back to normal operations"
 sytemctl stop sinusbot
sed -i 's/ -pwreset=foobar/ /g' /etc/systemd/system/sinusbot.service
systemctl daemon-reload
systemctl restart sinusbot
