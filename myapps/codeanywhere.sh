#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

#THIS FILE IS ONLY USED FOR DEVELOP ON CODEANYWHERE.COM

#http://port-5050.ubuntu-server-auto-install-tazboyz16.codeanyapp.com
apt update; apt upgrade -y --force-yes
apt install systemd software-properties-common nano dialog debconf apt-transport-https debconf-utils -y

cd myapps
cp -rf * /opt
