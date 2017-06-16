#!/bin/bash

echo "<--- Installing Plex Media Server ->"
bash /home/xxxusernamexxx/update/plexupdate.sh -p -a -d

echo "Installing 3rd Party Addons"
bash /home/xxxusernamexxx/install/PlexAddons/PlexAddons.sh
