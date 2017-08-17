#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Creation
# GNU General Public License v3.0
###########################################################

echo "<--- Setting up Samaba Smb Access Password --->"
echo -e "xxxpasswordxxx\nxxxpasswordxxx" | sudo smbpasswd -a xxxusernamexxx
echo "<--- Restoring Samba Settings --->"
cat /opt/install/Samba/Samba.txt > /etc/samba/smb.conf
systemctl restart smbd nmbd
