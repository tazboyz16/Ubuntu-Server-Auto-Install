#!/bin/bash

echo "<--- Setting up Samaba Smb Access Password --->"
echo -e "xxxpasswordxxx\nxxxpasswordxxx" | sudo smbpasswd -a xxxusernamexxx
echo "<--- Restoring Samba Settings --->"
cat /home/xxxusernamexxx/install/Samba/Samba.txt > /etc/samba/smb.conf
systemctl restart smbd nmbd
