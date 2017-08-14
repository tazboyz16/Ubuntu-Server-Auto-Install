#!/bin/bash

echo "Installing PlexRequests.NET (Ombi)"
apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
apt update; apt install mono-complete unzip -y
adduser --disabled-password --system --home /opt/ProgramData/Ombi --gecos "Ombi Service" --group ombi
mkdir /opt/Ombi && cd /opt/Ombi
wget $(curl -s https://api.github.com/repos/tidusjar/Ombi/releases/latest | grep 'browser_' | cut -d\" -f4)
unzip Ombi.zip && sudo rm Ombi.zip
chown -R ombi:ombi /opt/Ombi
chmod -R 0777 /opt/Ombi
echo "Creating Startup Script for PlexRequests"
cp /opt/install/Plex/ombi.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/ombi.service
systemctl enable ombi.service
systemctl restart ombi.service
