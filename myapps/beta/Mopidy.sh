#!/bin/bash
wget -q -O - https://apt.mopidy.com/mopidy.gpg | sudo apt-key add -
wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/jessie.list
apt get update; apt get install mopidy

#~/.config/mopidy/mopidy.conf
#mopidy config to effective configuration
#https://docs.mopidy.com/en/latest/service/#service

pip install Mopidy-Moped
# http://localhost:6680/moped
