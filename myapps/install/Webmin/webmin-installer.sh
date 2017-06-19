#!/bin/bash

echo "<-- Installing Deps and Webmin -->"
apt-get install -yqq perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions 
sleep 10

wget http://www.webmin.com/download/deb/webmin-current.deb -O /home/xxxusernamexxx/install/Webmin/webmin_all.deb

dpkg -i /home/xxxusernamexxx/install/Webmin/webmin_all.deb

echo "Restoring Webmin settings"
#cat /home/xxxusernamexxx/install/Webmin/Webmin.txt > /etc/webmin/miniserv.conf

sed -i "s/ssl= .*/ssl=1" /etc/webmin/miniserv.conf
sed -i "s/keyfile= .*/keyfile=/etc/apache2/ssl/apache.key" /etc/webmin/miniserv.conf
sed -i "s/ssl_redirect= .*/ssl_redirect=1" /etc/webmin/miniserv.conf
sed -i "s/certfile= .*/certfile=/etc/apache2/ssl/apache.crt" /etc/webmin/miniserv.conf

cat /home/xxxusernamexxx/install/Webmin/config > /etc/webmin/system-status/config

echo
sleep 1
echo '<--- All done. Webmin installation complete. --->'
echo

#Works 2/12/2017
echo "Creating Startup Script"
sudo update-rc.d webmin remove
cp /home/xxxusernamexxx/install/Webmin/webmin.service /etc/systemd/system/
chmod 644 /etc/systemd/system/webmin.service
systemctl enable webmin.service
systemctl restart webmin.service
