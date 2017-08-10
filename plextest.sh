#!/bin/bash

echo deb https://downloads.plex.tv/repo/deb ./public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

apt update
apt install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --force-yes plexmediaserver
