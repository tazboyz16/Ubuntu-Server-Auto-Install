#!/bin/bash

version=$(lsb_release -rs)

echo "<--- Adding Emby to Repository --->"
sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:/emby/xUbuntu_$version/ /' > /etc/apt/sources.list.d/emby-server.list"
echo "Grabbing Repository Key"
wget -nv http://download.opensuse.org/repositories/home:emby/xUbuntu_$version/Release.key -O Release.key
sudo apt-key add - < Release.key
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu" | sudo tee /etc/apt/sources.list.d/mono-offical.list
echo "<--- Installing Emby Server --->"
apt update; apt install mono-complete -y
apt install emby-server -y

systemctl enable emby-server
echo "<--- Finished Installing Emby Server --->"
