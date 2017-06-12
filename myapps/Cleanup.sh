#!/bin/bash

echo "<---- Cleaning Up Install files --->"
rm -r /home/xxxusernamexxx/WebTools.bundle/
rm -r /home/xxxusernamexxx/install/
rm -r /home/xxxusernamexxx/ts3/
rm -r /home/xxxusernamexxx/iRedMail-*
rm -r /home/xxxusernamexxx/sinusbot/

sudo chmod 0777 -R /opt/
sudo apt-get update -qq
sudo apt-get upgrade -yqq


systemctl disable Installserver.service
systemctl mask Installserver.service
