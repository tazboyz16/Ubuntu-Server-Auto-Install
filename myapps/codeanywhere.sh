#/bin/bash
#http://port-5050.ubuntu-server-auto-install-tazboyz16.codeanyapp.com
apt update; apt upgrade -y --force-yes
apt install systemd software-properties-common nano dialog debconf apt-transport-https debconf-utils -y

cd myapps
cp -rf * /opt
