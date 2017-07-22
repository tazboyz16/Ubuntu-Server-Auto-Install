#! /bin/bash

server=/opt/ts3
backup=$server-backup
dl=/tmp

arch=`uname -m`
if [ "$arch" == "x86_64" ]; then
    arch="amd64"
else
    arch="x86"
fi

echo "Getting version number from teamspeak.com"
wget -q https://www.teamspeak.com/downloads --output-document=$dl/Temp
Version=$(grep -Pom 1 "server_linux_$arch-\K.*?(?=\.tar\.bz)" $dl/Temp)
rm $dl/Temp

if [ "$Version" == "" ]; then
    echo "Failed to get version!"
    exit
fi

if [ -a $server/version ]; then
    BK=$(cat $server/version)
else
    echo "Local server version not found, referring to backups"
    BK=$(ls $backup/ | cut -d':' -f1 | sort -n | tail -1)
    BK="$BK(1)"
    if [ "$BK" == "" ]; then
        echo 'Backups not found, creating backup directory defaulting to "Backup 1"'
        mkdir $backup
        BK="Backup 1"
    fi
fi

if [ "$1" == "check" ]; then
        echo "Server is up to date. (Version: $BK)"
        exit
elif [ "$BK" == "$Version" ]; then
    read -p "Server is up to date! ($Version) Update anyways? [y/n]" yn
    case $yn in
        [Yy]* );;
        * ) echo "Exiting..." &&  exit ;;
    esac
fi

echo "Updating from $BK to $Version..."

while true; do
    read -p "Do you wish to backup the existing server? [y/n]" yn
    case $yn in
        [Yy]* ) echo "Creating backup $BK" && cp -rf $server $backup/$BK && break;;
        [Nn]* ) break;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done

if [ "$1" == "backup" ]; then
    exit
fi

#Store variable for latest backup available
BK=$(ls $backup/ | cut -d':' -f1 | sort -n | tail -1)

$server/ts3server_startscript.sh stop
rm -rf $server
echo "Installing version: $Version"
wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2
tar -xjf $dl/package.tar.bz2 -C $dl/
mv $dl/teamspeak3-server_linux_$arch $server
rm $dl/package.tar.bz2
#Fetch files from latest backup
cp -r $backup/$BK/files $server/
#Fetch server db from latest backup
cp $backup/$BK/ts3server.sqlitedb $server/
echo $Version > $server/version
echo "Starting Updated Server"
$server/ts3server_startscript.sh start
