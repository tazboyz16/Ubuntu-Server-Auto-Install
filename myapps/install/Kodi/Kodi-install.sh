#!/bin/bash

#install is only for desktop environment 
#https://forum.kodi.tv/showthread.php?tid=210762 - non desktop gui
sudo add-apt-repository -y ppa:team-xbmc/ppa
sudo apt-get update
sudo apt-get install -yqq kodi
