#!/bin/bash
echo
echo "<--- Adding Emby to Repository --->"
add-apt-repository "deb http://download.opensuse.org/repositories/home:emby/xUbuntu_16.04/ /"
echo "<--- Installing Emby Server --->"
apt get update; apt get install emby-server -y

systemctl enable emby-server

echo "<--- Finished Installing Emby Server --->"
