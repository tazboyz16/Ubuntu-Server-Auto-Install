#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

adduser --disabled-password --system --home /opt/ProgramData/jackett --gecos "Jackett Service" --group jackett

apt-key adv --keyserver hkp://keyserver.ubuntu.com --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb http://download.mono-project.com/repo/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/mono-offical.list

apt install mono-complete libcurl4-openssl-dev -y

cd
wget $(curl -s https://api.github.com/repos/Jackett/Jackett/releases/latest | grep 'Jackett.Binaries.Mono.tar.gz' | cut -d\" -f4)
tar -xvf Jackett.Binaries.Mono.tar.gz && sudo rm Jackett.Binaries.Mono.tar.gz
mkdir /opt/Jackett
mv Jackett/* /opt/Jackett
chmod 0777 -R /opt/Jackett
chown -R jackett:jackett /opt/Jackett


echo "Creating Startup Script"
cp /opt/install/Jackett/jackett.service /etc/systemd/system/
chmod 644 /etc/systemd/system/jackett.service
systemctl enable jackett.service
systemctl restart jackett.service
