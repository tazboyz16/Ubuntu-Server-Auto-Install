#!/bin/bash

echo "<-- Installing Deps and Webmin -->"
apt install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python -y
sleep 10

wget http://www.webmin.com/download/deb/webmin-current.deb -O /opt/install/Webmin/webmin_all.deb
dpkg -i /opt/install/Webmin/webmin_all.deb

echo "Restoring Webmin settings"
cat /opt/install/Webmin/Webmin.txt > /etc/webmin/miniserv.conf
cat /opt/install/Webmin/config > /etc/webmin/system-status/config

echo
sleep 1
echo '<--- All done. Webmin installation complete. --->'
echo

#Works 2/12/2017
echo "Creating Startup Script"
sudo update-rc.d webmin remove
cp /opt/install/Webmin/webmin.service /etc/systemd/system/
chmod 644 /etc/systemd/system/webmin.service
systemctl enable webmin.service
systemctl restart webmin.service
