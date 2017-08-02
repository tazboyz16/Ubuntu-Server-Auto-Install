#!/bin/bash

tar xf roundcubemail-*.tar.gz
sleep 10

cd /opt/roundcubemail-*
cp -r index.php /opt/www/roundcubemail-*/

cp -r bin/ /opt/www/roundcubemail-*/
cp -r SQL/ /opt/www/roundcubemail-*/
cp -r program/ /opt/www/roundcubemail-*/
cp -r installer/ /opt/www/roundcubemail-*/


cp -r config/defaults.inc.php /opt/www/roundcubemail-*/config/
rm -rf config/defaults.inc.php
cp -r config/mimetypes.php /opt/www/roundcubemail-*/config/
rm -rf config/mimetypes.php

sudo rsync -a skins/ /opt/www/roundcubemail-*/skins
sudo rsync -a plugins/ /opt/www/roundcubemail-*/plugins
sudo rsync -a vendor/ /opt/www/roundcubemail-*/vendor

echo "?" | sudo php bin/update.sh /opt/www/roundcubemail-*

cd
echo "Finished Updating Roundcube Mail"
