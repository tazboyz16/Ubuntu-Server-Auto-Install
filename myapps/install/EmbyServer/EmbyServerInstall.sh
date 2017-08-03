#!/bin/bash

version=$(lsb_release -rs)
echo "<--- Adding Emby to Repository --->"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/emby/xUbuntu_$version/ /' > /etc/apt/sources.list.d/emby-server.list"
echo "<--- Installing Emby Server --->"
apt update; apt install emby-server -y

systemctl enable emby-server

echo "<--- Finished Installing Emby Server --->"
