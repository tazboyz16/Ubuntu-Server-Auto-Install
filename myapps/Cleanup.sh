#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "<---- Cleaning Up Install files --->"
rm -r /opt/WebTools.bundle/

sudo chmod 0777 -R /opt/
sudo apt-get update -qq
sudo apt-get upgrade -yqq

systemctl disable Installserver.service
systemctl mask Installserver.service
