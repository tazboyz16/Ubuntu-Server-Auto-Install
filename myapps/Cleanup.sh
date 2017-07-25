#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "<---- Cleaning Up Install files --->"
rm -r /opt/WebTools.bundle/
rm -r /opt/install/
rm -r /opt/ts3/
rm -r /opt/iRedMail-*
rm -r /opt/sinusbot/
rm -r /opt/Jackett

sudo chmod 0777 -R /opt/
sudo apt-get update -qq
sudo apt-get upgrade -yqq

systemctl disable Installserver.service
systemctl mask Installserver.service
