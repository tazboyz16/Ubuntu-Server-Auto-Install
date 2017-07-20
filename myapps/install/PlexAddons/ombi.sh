#!/bin/bash

echo "Installing PlexRequests.NET (Ombi)"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt install mono-complete unzip -y
sudo adduser --disabled-password --system --no-create-home --gecos "Ombi Service" --group ombi
sudo mkdir /opt/Ombi && cd /opt/Ombi
sudo wget $(curl -s https://api.github.com/repos/tidusjar/Ombi/releases/latest | grep 'browser_' | cut -d\" -f4)
sudo unzip Ombi.zip && sudo rm Ombi.zip
sudo chown -R ombi:ombi /opt/Ombi
sudo chmod -R 0777 /opt/Ombi
echo "Creating Startup Script for PlexRequests"
cp /opt/install/PlexAddons/ombi.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/ombi.service
systemctl enable ombi.service
systemctl restart ombi.service
