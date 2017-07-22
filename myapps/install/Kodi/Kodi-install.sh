#!/bin/bash

#Kodi Requires Desktop Gui to function
#this bash script will install Kodi with its own Desktop gui on start up 

cd /opt && git clone https://github.com/abacao/Kodi17-UbuntuServer.git
cd Kodi17-UbuntuServer
sudo ./install.sh
