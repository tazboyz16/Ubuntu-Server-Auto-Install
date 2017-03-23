#!/bin/bash

#http://www.webupd8.org/2015/05/grive2-grive-fork-with-google-drive.html has the DEB File ftp link

echo "<--- Installing Grive --->"
sudo add-apt-repository -y ppa:nilarimogard/webupd8
echo "<-- Installing dependencies for Grive for Website Sync -->"
sudo apt-get update
sudo apt-get install -yqq grive
