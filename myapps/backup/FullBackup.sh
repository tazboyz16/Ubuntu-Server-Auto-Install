#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#/opt/Backup  location

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#SickRage
cd /opt/SickRage
sudo tar -cvjSf SickRage.tar.bz2 *

