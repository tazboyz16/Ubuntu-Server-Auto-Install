#!/bin/bash
#requires curl, libcurl3
#initial variables
SCRIPT_NAME='getplexserver'			            # name of this file
TARGETAPP='Plex Media Server'			            # name of the target application
PKG_NAME='plexmediaserver'		                    # name of target package
SCRAPELINK='https://plex.tv/downloads?channel=plexpass'     # Scrape link to vendor site
DOWNLOADLINK='https://downloads.plex.tv/plex-media-server' # Download link to vendor site
######################################################################
#Check to be sure URLs are still good
######################################################################
check_urls(){
SCRAPECHECK=$(curl -s --head $SCRAPELINK | head -n 1 | awk ' { print $2 }')
# I couldn't get this next line to work. Might not be needed anyway
#DOWNLOADCHECK=$(curl -s --head $DOWNLOADLINK | head -n 1 | awk ' { print $2} ' )
    if (($SCRAPECHECK!=200))
        then 
            echo "Sorry, URL is bad. Check with Plex and edit this script"
            exit 1
    fi
}
######################################################################
# This will set the variable named MYVER with the currently 
# installed version of Plex.
######################################################################
get_installed_ver(){
        if [ -e /usr/lib/plexmediaserver/Plex\ Media\ Server ]
            then
                MYVER=$(dpkg-query -W plexmediaserver | awk ' { print$2 } ')
                echo "Currently installed version of $TARGETAPP is $MYVER"
            else
                MYVER=''
                echo "$TARGETAPP is not currently installed."
        fi
}
######################################################################
# Get Vendor Version 
######################################################################
###
### This is scanning for .deb files only. If you use .rpm you'll need 
### to modify here.
###
get_vendor_ver(){
	# Get the current version from Plex for Ubuntu
	CURVER=$(awk 'BEGIN { FS = "/" } { print $5 }' <<< `curl -sk $SCRAPELINK |grep '.deb' `)
}
######################################################################
# The actual download-install
######################################################################
fetch_and_install(){
	echo "Retrieving $TARGETAPP version $CURVER..."
	# Download the file
	wget ${DOWNLOADLINK}/${CURVER}/${PKG_NAME}_${CURVER}_${ARCH}.deb
	# Install the latest and greatest version of the server
	echo "Installing..."
	dpkg -i ${PKG_NAME}_${CURVER}_${ARCH}.deb
	# Remove the file if it's no longer wanted
	if [ $KEEPPKG = 'no' ] 
            then
                echo "Deleting download..."
                rm ${PKG_NAME}_${CURVER}_${ARCH}.deb
        fi
}
######################################################################
# Main code
######################################################################
# Initial setup and queries.
echo ""
# check for sudo
THISUSER=$(whoami)
    if [ $THISUSER != 'root' ] 
        then
            echo 'You must use sudo to run this script, sorry!'
            exit 1
    fi
###
### I wrote this for myself and I use Ubuntu server. I will probably work 
### for other debian based distros as is, but this section will need to be modified
###
# Check for Ubunutu
MAKER=$(lsb_release -i |awk ' { print $3 } ')
    if [ $MAKER != 'Ubuntu' ]
        then
            echo 'This script is designed specifically'
            echo 'for Ubuntu based distros, sorry!'
            exit 1
    fi
# Verify desire to continue or quit.
echo "About to install or upgrade $TARGETAPP. "
echo "Continue?"
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
          break
        ;;
        No ) 
          exit 0
        ;;
    esac
done
check_urls
# Keep downloaded package or delete?
echo "Do you wish to keep the downloaded package after this script is done?"
KEEPPKG=''
select yn in "Yes" "No"
do
    case $yn in
        Yes ) 
          KEEPPKG='yes' 
          break
        ;;
        No ) 
          KEEPPKG='no' 
          break
        ;;
    esac
done
###
### If you modify this script for your NAS or other type hardware
### you may need to change this section or remove it
###
# Set the relevant architecture based on installed OS type
ARCH='i386'
OSVER=$(uname -i)    
    if [ $OSVER = 'x86_64' ]
        then
            ARCH='amd64'
    fi
# Check for version already installed
get_installed_ver
# Get latest version from vendor and quit if up-to-date
get_vendor_ver
    if [ "$CURVER" = "$MYVER" ]
        then
            echo "You are up to date."
            exit 0
    fi
# do it already
# download_and_install
# Already installed, so check if we should upgrade
    if [ -z $MYVER ]
            then
		echo "Installing $TARGETAPP version $CURVER..."
            else
		echo "Upgrading $TARGETAPP from $MYVER to $CURVER"
    fi
fetch_and_install
echo "All done. $TARGETAPP version $CURVER is now installed" 
exit 0
