#!/bin/bash

SCRIPTPATH=/opt/beta

MAINCHOICE=$(whiptail --title "Port Reconfigure" \
--menu "Which app would you like to manage?" --backtitle "$BACKTITLE" \
--fb --cancel-button "Exit" $LINES $COLUMNS "$NETLINES" \
"Media Servers" "Organise and serve Media" \
"Media Finders" "Media Manager and Downloaders" \
"Bittorrent & Usenet Clients" "Download Torrents" \
"Admin Tools" "system configuration tools e.g. Webmin" \
"Voip Server" "TeamSpeak Server" \
"Home Security" "Personal home IpCamera Security" 3>&1 1>&2 2>&3)

exitstatus=$?
if [[ $exitstatus = 0 ]]; then
    source "$SCRIPTPATH/inc/app-constant-reset.sh"
    case "$MAINCHOICE" in
        "Media Servers" )
            source "$SCRIPTPATH/menus/Media Servers.sh" ;;
        "Media Finders" )
            source "$SCRIPTPATH/menus/Media Finders.sh" ;;
        "Bittorrent & Usenet Clients" )
            source "$SCRIPTPATH/menus/menu-bittorrent.sh" ;;
        "Admin Tools" )
            source "$SCRIPTPATH/menus/menu-Admin-Tools.sh" ;;
        "Home Theater" )
            source "$SCRIPTPATH/menus/menu-Voip-Server.sh" ;;
        "Sync Tools" )
            source "$SCRIPTPATH/menus/menu-Home-Security.sh" ;;
        *)
            exit 0
    esac
else
    echo
    sleep 1
    exit 0
fi
