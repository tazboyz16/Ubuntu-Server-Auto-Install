#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

time=$(date +"%m_%d_%y-%H_%M")

#/opt/Backup  location
#/opt/install for install script loactions

bashloc='/opt/install'

#Apache
if [ ! -d /etc/apache2 ]; then
		echo "Apache2 not installed"
	else
	    bash $bashloc/Apache2/Apache2-install.sh -b
	    echo "Done Backing Up Apache2"
		fi

#Couchpotato
if [ ! -d /opt/CouchPotato ]; then
		echo "CouchPotato not installed"
	else
	    bash $bashloc/CouchPotato/couchpotato-installer.sh -b
	    echo "Done Backing up CouchPotato"
		fi

#Deluge
if [ ! -d /opt/Deluge ]; then
		echo "Deluge not installed"
	else
	    bash $bashloc/Deluge/deluge_webui.sh -b
	    echo "Done Backing up Deluge"
		fi

#Emby
if [ ! -d /usr/lib/emby-server ]; then
		echo "Emby not installed"
	else
	    bash $bashloc/EmbyServer/EmbyServerinstall.sh -b
	    echo "Done Backing up EmbyServer"
		fi

#Glances
if [ ! -d /etc/glances ]; then
		echo "Glances not installed"
	else
	    echo "WIP Glances"
	    #bash $bashloc/EmbyServer/EmbyServerinstall.sh -b
	    #echo "Done Backing up EmbyServer"
		fi

#Grive    
if [ ! -d /usr/share/doc/grive ]; then
		echo "Grive not installed"
	else
	    echo "WIP Grive"
	    #bash $bashloc/EmbyServer/EmbyServerinstall.sh -b
	    #echo "Done Backing up EmbyServer"
		fi
		
#Headphones
if [ ! -d /opt/Headphones ]; then
		echo "Headphones not installed"
	else
	    bash $bashloc/Headphones/headphones-installer.sh -b
	    echo "Done Backing up Headphones"
		fi
		
#HTPCManager
if [ ! -d /opt/HTPCManager ]; then
		echo "HTPCManager not installed"
	else
	    bash $bashloc/HTPCManager/HTPCManager.sh -b
	    echo "Done Backing up HTPCManager"
		fi
		
#Iredmail
if [ ! -d /opt/iredapd ]; then
		echo "iRedMail not installed"
	else
	    echo "WIP iRedMail"
	    #bash $bashloc/HTPCManager/HTPCManager.sh -b
	    #echo "Done Backing up HTPCManager"
		fi
		
#Jackett
if [ ! -d /opt/Jackett ]; then
		echo "Jackett not installed"
	else
	    bash $bashloc/Jackett/jackettinstall.sh -b
	    echo "Done Backing up Jackett"
		fi
		
#Lazylibrarian
if [ ! -d /opt/LazyLibrarian ]; then
		echo "LazyLibrarian not installed"
	else
	    bash $bashloc/Lazylibrarian/Lazylibrarian.sh -b
	    echo "Done Backing up LazyLibrarian"
		fi
		
#Madsonic
if [ ! -d /etc/init.d/madsonic ]; then
		echo "Madsonic not installed"
	else
	    bash $bashloc/Madsonic/MadSonic.sh -b
	    echo "Done Backing up Madsonic"
		fi
		
#Mopidy
if [ ! -d /usr/bin/mopidy ]; then
		echo "Mopidy not installed"
	else
	    bash $bashloc/Mopidy/Mopidyinstall.sh -b
	    echo "Done Backing up Mopidy"
		fi
		
#Muximux
if [ ! -d /opt/Muximux/ ]; then
		echo "Muximux not installed"
	else
	    bash $bashloc/Muximux/Muximuxinstall.sh -b
	    echo "Done Backing up Muximux"
		fi
		
#Mylar
if [ ! -d /opt/Mylar ]; then
		echo "Mylar not installed"
	else
	    bash $bashloc/Mylar/mylar-installer.sh -b
	    echo "Done Backing up Mylar"
		fi
		
#Noipy
if [ ! -d /usr/local/lib/python2.7/dist-packages/noipy ]; then
		echo "Noipy not installed"
	else
	    echo "WIP Noipy"
	    #bash $bashloc/HTPCManager/HTPCManager.sh -b
	    #echo "Done Backing up HTPCManager"
		fi
		
#Nzbget
if [ ! -d /opt/Nzbget ]; then
		echo "Nzbget not installed"
	else
	    bash $bashloc/Nzbget/Nzbget.sh -b
	    echo "Done Backing up Nzbget"
		fi

#Nzbhydra
if [ ! -d /opt/Nzbhydra ]; then
		echo "Nzbhydra not installed"
	else
	    bash $bashloc/Nzbhydra/Nzbhydra.sh -b
	    echo "Done Backing up Nzbhydra"
		fi
		
#Organizr
if [ ! -d /opt/Organizr ]; then
		echo "Organizr not installed"
	else
	    bash $bashloc/Organizr/Organizr.sh -b
	    echo "Done Backing up Organizr"
		fi
		
#Plex
if [ ! -d /var/lib/plexmediaserver ]; then
		echo "Plex Media Server not installed"
	else
	    echo "WIP for backing up Plex"
	    #bash $bashloc/Plex/plexinstall.sh -b
	    #echo "Done Backing up Plex"
		fi
		
#PlexAddons - Ombi
if [ ! -d /opt/Ombi/ ]; then
		echo "Ombi not installed"
	else
	    bash $bashloc/Plex/ombi.sh -b
	    echo "Done Backing up Ombi"
		fi		
		
#PlexAddons - Plexpy
if [ ! -d /opt/Plexpy/ ]; then
		echo "Plexpy not installed"
	else
	    bash $bashloc/Plex/plexpy.sh -b
	    echo "Done Backing up Plexpy"
		fi
		
#PlexAddons - Webtools
if [ ! -d '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'* ]; then
		echo "No Third Party Plex Addons installed"
	else
	    echo "WIP Webtools"
	    #bash $bashloc/Plex/plexpy.sh -b
	    #echo "Done Backing up Plexpy"
		fi

#Radarr
if [ ! -d /opt/Radarr ]; then
		echo "Radarr not installed"
	else
	    bash $bashloc/Radarr/radarrinstall.sh -b
	    echo "Done Backing up Radarr"
		fi
#Samba
if [ ! -d /etc/samba ]; then
		echo "Samba not installed"
	else
	    echo "WIP Samba to be added to Samba installer"
	    #bash $bashloc/Samba/samba.sh -b
	    #echo "Done Backing up Samba"
		fi
		
#Shinobi
if [ ! -d /opt/Shinobi ]; then
		echo "Shinobi not installed"
	else
	    bash $bashloc/Shinobi/Shinobi.sh -b
	    echo "Done Backing up Shinobi"
		fi
		
#SickRage
if [ ! -d /opt/SickRage ]; then
		echo "SickRage not installed"
	else
	    bash $bashloc/Sickrage/sickrage-installer.sh -b
	    echo "Done Backing up SickRage"
		fi
		
#Sinusbot
if [ ! -d /opt/Sinusbot/ ]; then
		echo "Sinusbot not installed"
	else
	    bash $bashloc/SinusBot/sinusbot.sh -b
	    echo "Done Backing up Sinusbot"
		fi
		
#Sonarr
if [ ! -d /opt/NzbDrone ]; then
		echo "Sonarr not installed"
	else
	    bash $bashloc/Sonarr/Sonarrinstall.sh -b
	    echo "Done Backing up Sonarr"
		fi
		
#System Settings      #grab host, cronjobs...
	    echo "WIP for backing up System Config files"
	    #bash $bashloc/Sonarr/Sonarrinstall.sh -b
	    #echo "Done Backing up Sonarr"

		
#Teamspeak Server
if [ ! -d /opt/ts3 ]; then
		echo "Teamspeak Server not installed"
	else
	    bash $bashloc/TeamSpeak3/ts3update.sh -b
	    echo "Done Backing up TeamSpeak Server"
		fi
		
#Ubooquity
if [ ! -d /opt/Ubooquity ]; then
		echo "Ubooquity not installed"
	else
	    bash $bashloc/Ubooquity/Ubooquity.sh -b
	    echo "Done Backing up Ubooquity"
		fi
		
#Webmin
if [ ! -d /etc/webmin/ ]; then
		echo "Webmin not installed"
	else
	    bash $bashloc/Webmin/webmin-installer.sh -b
	    echo "Done Backing up Webmin"
		fi
		
#Zoneminder
if [ ! -d /usr/share/zoneminder ]; then
		echo "Zoneminder not installed"
	else
	    bash $bashloc/Zoneminder/zminstall.sh -b
	    echo "Done Backing up Zoneminder"
		fi


#Grab all .ta.gz files to tar into a Fullbackup tar with date/time stamp
if [ ! -d /opt/backup/Full_Backups ]; then
		mkdir /opt/backup/Full_Backups
fi

if [ ! -d /opt/backup/FullBackup ]; then
		mkdir /opt/backup/FullBackup
fi

if [ -f /opt/backup/.tempfile ]; then
		rm /opt/backup/.tempfile
fi

if [ -f /opt/backup/FullBackup*.tar.gz ]; then
		mv /opt/backup/FullBackup*.tar.gz /opt/backup/Full_Backups/
fi

mv /opt/backup/*.tar.gz /opt/backup/FullBackup/
tar -zcvf /opt/backup/FullBackup-$time.tar.gz /opt/backup/FullBackup/
