#!/bin/bash

echo "<--- Installing Plex Media Server ->"
bash /home/taz/update/plexupdate.sh -p -a -d

echo "Installing 3rd Party Addons"
bash /home/taz/install/PlexAddons/PlexAddons.sh
