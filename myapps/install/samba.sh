#!/bin/bash

echo "<--- Setting up Samaba Smb Access Password --->"
echo -e "xxxSambaPasswordxxx\nxxxSambaPasswordxxx" | sudo smbpasswd -a xxxusernamexxx
echo "<--- Restoring Samba Settings --->"
cat /home/xxxusernamexxx/install/configs/programs/Samba.txt > /etc/samba/smb.conf
systemctl restart samba
