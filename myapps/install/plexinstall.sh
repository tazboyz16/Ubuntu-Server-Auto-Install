#!/bin/bash

echo "<--- Installing Plex Media Server ->"
bash /home/xxxusernamexxx/update/plexupdate.sh -p -a -d -u

echo "Installing 3rd Party Addons"
bash /home/xxxusernamexxx/install/Webtools.sh

echo "Installing PlexPy"
sudo adduser --disabled-password --system --no-create-home --gecos "PlexPy Service"  --group plexpy
cd /opt && sudo git clone https://github.com/JonnyWong16/plexpy.git
sudo chown -R plexpy:plexpy /opt/plexpy
sudo chmod -R 0777 /opt/plexpy
echo "Creating Startup Script for PlexPy"
cp /home/xxxusernamexxx/install/Services/plexpy.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/plexpy.service
systemctl enable plexpy.service
systemctl restart plexpy.service

echo "Installing PlexRequests.NET"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
sudo apt-get update
sudo apt-get install mono-complete unzip -y
sudo adduser --disabled-password --system --no-create-home --gecos "Ombi Service" --group ombi
sudo mkdir /opt/ombi && cd /opt/ombi
sudo wget $(curl -s https://api.github.com/repos/tidusjar/Ombi/releases/latest | grep 'browser_' | cut -d\" -f4)
sudo unzip Ombi.zip && sudo rm Ombi.zip
sudo chown -R ombi:ombi /opt/ombi
sudo chmod -R 0777 /opt/ombi
echo "Creating Startup Script for PlexRequests"
cp /home/xxxusernamexxx/install/Services/ombi.service /etc/systemd/system/
chmod 0777 /etc/systemd/system/ombi.service
systemctl enable ombi.service
systemctl restart ombi.service
