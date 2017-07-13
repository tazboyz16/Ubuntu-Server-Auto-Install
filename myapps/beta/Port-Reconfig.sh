#!/bin/bash

clear
menua=0
menub=0
Port=0

clear
echo "*-*-*-*-*-*Port ReConfigure*-*-*-*-*-*"
echo "What Program or App to Change Port on?"
echo "1) Media Servers"
echo "2) Media Finders/Managers"
echo "3) Downloaders"
echo "4) Admin Tools"
echo "5) VOIP Server"
echo "6) Home Security"
echo "9) Exit"
read menua

case $menua in
    1)
    clear
    echo "Media Servers"
    echo "1) Emby Media Server"
    echo "2) Plex Media Server"
    read menub
    ;;
    2)
    clear
    echo "Media Finders/Managers"
    echo "1) CouchPotato"
    echo "2) Headphones"
    echo "3) HTPCManager"
    echo "4) LazyLibrarian"
    echo "5) Mylar"
    echo "6) Muximux"
    echo "7) Radarr"
    echo "8) SickRage"
    echo "9) Sonarr"
    echo "10) Jackett"
    echo "11) Ubooquity"
    readmenub
    ;;
    3)
    clear
    echo "Content Downloaders"
    echo "1) Deluge w/ Web UI"
    echo "2) NZBGet"
    echo "3) Sabzbd"
    read menub
    ;;
    4)
    clear
    echo "Admin Tools"
    echo "1) Webmin"
    echo "2) Noip2"
    echo "3) Grive"
    read menub
    ;;
    5)
    clear
    echo "VOIP Server"
    echo "1) TeamSpeak 3 Server"
    echo "2) Sinusbot"
    read menub
    ;;
    6)
    clear
    echo "Home Security"
    echo "1) ZoneMinder"
    echo "2) Shinobi"
    read menub
    ;;
    9)
    exit 0
    ;;
esac

echo $menua $menub

if [ $menua == 1 ]
then
    case $menub in
    1)
    clear
    echo "Emby Media Server Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "Plex Media Server Port Change"
    echo "might not be able to change ports"
    read Port
    exit 0
    ;;
esac
fi

if [ $menua == 2 ]
then
    case $menub in
    1)
    clear
    echo "CouchPotato Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "Headphones Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    3)
    echo "HTPCManager Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    4)
    echo "LazyLibrarian Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    5)
    echo "Mylar Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    6)
    echo "Muximux Port Change"
    echo "**uses apache**"
    read Port
    exit 0
    ;;
    7)
    echo "Radarr Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    8)
    echo "SickRage Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    9)
    echo "Sonarr Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    10)
    echo "Jackett Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "Ubooquity Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
esac
fi

if [ $menua == 3 ]
then
    case $menub in
    1)
    clear
    echo "Deluge w/ Web UI Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "NZBGet Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    3)
    echo "Sabnzbd Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
esac
fi

if [ $menua == 4 ]
then
    case $menub in
    1)
    clear
    echo "Grive Port Change"
    echo "What New hange to?"
    read Port
    exit 0
    ;;
    2)
    echo "Noip2 Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    3)
    echo "Webmin Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
esac
fi

if [ $menua == 5 ]
then
    case $menub in
    1)
    clear
    echo "Sinusbot Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "TeamSpeak 3 Server Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
esac
fi

if [ $menua == 6 ]
then
    case $menub in
    1)
    clear
    echo "Shinobi Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
    2)
    echo "ZoneMinder Port Change"
    echo "What New Port Would you like to change to?"
    read Port
    exit 0
    ;;
esac
fi
