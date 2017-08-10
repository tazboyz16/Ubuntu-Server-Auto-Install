#!/bin/bash

echo deb https://downloads.plex.tv/repo/deb ./public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

apt update
apt install Dpkg::Options::"--force-confold" plexmediaserver
