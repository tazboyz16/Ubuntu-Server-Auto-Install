#!/bin/bash

apt-get install -yqq apache2
sleep 15
echo "<--- Restoring Apache2 Settings --->"
cat /home/xxxusernamexxx/install/configs/apache2/apache2.conf > /etc/apache2/apache2.conf
sleep 5
echo "<- Restoring Apache2 Error Pages ->"
cat /home/xxxusernamexxx/install/configs/apache2/localized-error-pages.conf > /etc/apache2/conf-available/localized-error-pages.conf
systemctl restart apache2

#echo "<--- Moving WWW files for Website --->"
#rm -rf /var/www
#tar xjf /home/xxxusernamexxx/install/www.tar.bz2
#mv /home/xxxusernamexxx/www/ /var
#echo
#echo "<--- Changing Rights for dir WWW --->"
#chmod 0777 -R /var/www
#chown xxxusernamexxx:xxxusernamexxx -R /var/www

