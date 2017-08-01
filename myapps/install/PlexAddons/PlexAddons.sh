#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

bash /opt/install/PlexAddons/plexpy.sh
bash /opt/install/PlexAddons/ombi.sh
bash /opt/install/PlexAddons/Webtools.sh
