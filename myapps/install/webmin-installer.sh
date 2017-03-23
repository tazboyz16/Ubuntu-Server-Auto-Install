#!/bin/bash

echo "<-- Installing Deps and Webmin -->"
apt-get install -yqq perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions 
sleep 10
dpkg -i /home/xxxusernamexxx/install/webmin_*

echo "Restoring Webmin settings"
cat /home/xxxusernamexxx/install/configs/Webmin/Webmin.txt > /etc/webmin/miniserv.conf
cat /home/xxxusernamexxx/install/configs/Webmin/config > /etc/webmin/system-status/config

echo
sleep 1
echo '<--- All done. Webmin installation complete. --->'
echo

echo "Creating Startup Script"
sudo update-rc.d webmin remove
cp /home/xxxusernamexxx/install/Services/webmin.service /etc/systemd/system/
chmod 644 /etc/systemd/system/webmin.service
systemctl enable webmin.service
systemctl restart webmin.service
