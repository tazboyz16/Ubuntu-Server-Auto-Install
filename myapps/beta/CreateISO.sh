#!/bin/bash

#Example Locations of Ubuntu ISOs
#http://releases.ubuntu.com/16.04/
#http://releases.ubuntu.com/16.04.2/
#http://releases.ubuntu.com/16.10/
#http://releases.ubuntu.com/17.04/
#http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-desktop-amd64.iso
#http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-desktop-i386.iso
#http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-server-amd64.iso
#http://releases.ubuntu.com/16.04.2/ubuntu-16.04.2-server-i386.iso

echo "Fully Automated Script to Download Your Ubuntu ISO, "
echo "Unpack it, edit the MyApps Scripts and then ReImage the ISO back together for you"

echo "Where is the Myapps Folder located at?
echo "If located in Your Home Dir please add the Full location with /home/'username' "
read WorkingDir

rm $WorkingDir/README.md
rm $WorkingDir/_config.yml

echo "Admin Account UserName?"
read AdminUsername

echo "Admin Account Password?"
read AdminPassword

