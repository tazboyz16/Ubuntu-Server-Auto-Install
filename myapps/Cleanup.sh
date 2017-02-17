#!/bin/bash


echo "<---- Cleaning Up Install files --->"
rm -r /home/taz/WebTools.bundle/
rm -r /home/taz/install/
rm -r /home/taz/ts3/
rm -r /home/taz/iRedMail-*
rm -r /home/taz/sinusbot/

sudo chmod 0777 -R /opt/
sudo apt-get update -qq
sudo apt-get upgrade -yqq

