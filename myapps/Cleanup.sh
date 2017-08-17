#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "<---- Cleaning Up Install files --->"
rm -r /opt/WebTools.bundle/

chmod 0777 -R /opt/
apt get update; apt get upgrade -y

systemctl disable Installserver.service
systemctl mask Installserver.service
