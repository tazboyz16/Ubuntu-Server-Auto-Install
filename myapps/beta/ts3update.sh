#! /bin/bash

#Modes 
# b=backup i=install ri=reinstall r=restore u=update U=Force Update
mode=i
server=/opt/ts3
backupdir=/opt/backup/ts3
dl=/tmp
BK=$(cat $server/version)
force=0

echo "Preforming System Check Up and Getting Latest Version Number from TeamSpeak"
#System Specs
arch=`uname -m`
if [ "$arch" == "x86_64" ]; then
    arch="amd64"
else
    arch="x86"
fi

#making sure Backup Dir exist
mkdir $backupdir

#Getting Current Version Info
wget -q https://www.teamspeak.com/downloads --output-document=$dl/Temp
Version=$(grep -Pom 1 "server_linux_$arch-\K.*?(?=\.tar\.bz)" $dl/Temp)
rm $dl/Temp
if [ "$Version" == "" ]; then
    echo "Failed to get version!"
    exit
fi

#Checking if there was any Arguments with starting the script
while true;
do
case "$1" in
    (-b) backup;;
    (-i) install;;
    (-r) restore;;
    (-ri) reinstall;;
    (-u) update;;
    (-U) force=1; update;;
    (-*) echo "Invalid Argument"; exit 0;;
    (*) break;;
esac
done

backup() {

}

install() {
sudo ln -s /opt/ts3/redist/libmariadb.so.2 /opt/ts3/libmariadb.so.2



echo "Creating Startup Script"
cp /opt/install/TeamSpeak3/ts3.service /etc/systemd/system/
chmod 644 /etc/systemd/system/ts3.service
systemctl enable ts3.service
systemctl restart ts3.service
}

restore() {

}

reinstall() {

}

update() {
if [ "$BK" == "$Version" ]; then
    case $force in
    0)
    echo= "Server is up to date! Latest Version is ($Version). If you want to still install over Installation"
    echo= "Run Script with '-U' to Force Update"
    exit 0
    ;;
    *)
    ;;
    esac
fi

echo "Stopping TS3 Server"
systemctl stop ts3

echo "Running Backup of Settings and DB of TeamSpeak Server Before Update"
cp $server/query_ip_blacklist.txt $backupdir
cp $server/query_ip_whitelist.txt $backupdir
cp $server/ts3server.ini $backupdir
cp $server/ts3db_mariadb.ini $backupdir
cp $server/ts3server.sqlitedb $backupdir

echo "Downloading Latest Version of TeamSpeak 3 Server"
wget -nv http://teamspeak.gameserver.gamed.de/ts3/releases/$Version/teamspeak3-server_linux_$arch-$Version.tar.bz2 --output-document=$dl/package.tar.bz2

echo "Installing TS3 Server Version $Version"
tar -xjf $dl/package.tar.bz2 -C $dl/
mv $dl/teamspeak3-server_linux_$arch $server
rm $dl/package.tar.bz2

echo "Moving back Settings and DB back to TS3 Folder"
mv $backupdir/query_ip_blacklist.txt $server
mv $backupdir/query_ip_whitelist.txt $server
mv $backupdir/ts3server.ini $server
mv $backupdir/ts3db_mariadb.ini $server
mv $backupdir/ts3server.sqlitedb $server

echo $Version > $server/version
echo "Starting Updated Server"
systemctl start ts3
}

exit 0

######################################
#Store variable for latest backup available
#BK=$(ls $backup/ | cut -d':' -f1 | sort -n | tail -1)

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
