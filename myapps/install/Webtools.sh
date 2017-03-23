#!/bin/bash

systemctl stop plexmediaserver
sleep 15
sudo chmod 0777 -R /var/lib/plexmediaserver
sleep 25
sudo mkdir -p '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins'

echo "Installing Afdah"
sudo git clone https://github.com/jwsolve/Afdah.bundle.git
cp -fR /home/xxxusernamexxx/Afdah.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/Afdah.bundle

echo "Installing Arconaitv"
sudo git clone https://github.com/piplongrun/arconaitv.bundle.git
cp -fR /home/xxxusernamexxx/arconaitv.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/arconaitv.bundle

echo "Installing BitTorrent"
sudo git clone https://github.com/sharkone/BitTorrent.bundle.git
cp -fR /home/xxxusernamexxx/BitTorrent.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/BitTorrent.bundle

echo "Installing BringThePopcorn"
sudo git clone https://github.com/MaZZly/BringThePopcorn.bundle.git
cp -fR /home/xxxusernamexxx/BringThePopcorn.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/BringThePopcorn.bundle

echo "Installing CcloudTv"
sudo git clone https://github.com/coder-alpha/CcloudTv.bundle.git
cp -fR /home/xxxusernamexxx/CcloudTv.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/CcloudTv.bundle

echo "Installing Channel OneThreeOne"
sudo git clone https://github.com/jwsolve/OneThreeOne.bundle.git
cp -fR /home/xxxusernamexxx/OneThreeOne.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/OneThreeOne.bundle

echo "Installing CouchPotato"
sudo git clone https://github.com/mikedm139/CouchPotato.bundle.git
cp -fR /home/xxxusernamexxx/CouchPotato.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/CouchPotato.bundle

echo "Installing Dailymotion"
sudo git clone https://github.com/plexinc-plugins/Dailymotion.bundle.git
cp -fR /home/xxxusernamexxx/Dailymotion.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/Dailymotion.bundle

echo "Installing FilmOn"
sudo git clone https://github.com/meriko/FilmOn.bundle.git
cp -fR /home/xxxusernamexxx/FilmOn.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/FilmOn.bundle

echo "Installing Fmovies"
sudo git clone https://github.com/LinusOS400/Fmovies.bundle.git
cp -fR /home/xxxusernamexxx/Fmovies.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/Fmovies.bundle

echo "Installing FMoviesPlus"
sudo git clone https://github.com/coder-alpha/FMoviesPlus.bundle.git
cp -fR /home/xxxusernamexxx/FMoviesPlus.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/FMoviesPlus.bundle

echo "Installing Headphones"
sudo git clone https://github.com/willpharaoh/headphones.bundle.git
cp -fR /home/xxxusernamexxx/headphones.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/headphones.bundle

echo "Installing IPTV"
sudo git clone https://github.com/Cigaras/IPTV.bundle.git
cp -fR /home/xxxusernamexxx/IPTV.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/IPTV.bundle

echo "Installing KissAnime"
sudo git clone https://github.com/jwsolve/KissAnime.bundle.git
cp -fR /home/xxxusernamexxx/KissAnime.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/KissAnime.bundle

echo "Installing KissCartoons"
sudo git clone https://github.com/jwsolve/KissCartoons.bundle.git
cp -fR /home/xxxusernamexxx/KissCartoons.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/KissCartoons.bundle

echo "Installing KissNetwork"
sudo git clone https://github.com/Twoure/KissNetwork.bundle.git
cp -fR /home/xxxusernamexxx/KissNetwork.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/KissNetwork.bundle

echo "Installing LihatTV"
sudo git clone https://github.com/Twoure/LihatTV.bundle.git
cp -fR /home/xxxusernamexxx/LihatTV.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/LihatTV.bundle

echo "Installing Putlocker"
sudo git clone https://github.com/jwsolve/Putlocker.bundle.git
cp -fR /home/xxxusernamexxx/Putlocker.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/Putlocker.bundle

echo "Installing SickBeard/SickRage"
sudo git clone https://github.com/mikedm139/SickBeard.bundle.git
cp -fR /home/xxxusernamexxx/SickBeard.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/SickBeard.bundle

echo "Installing Speedtest"
sudo git clone https://github.com/Twoure/Speedtest.bundle.git
cp -fR /home/xxxusernamexxx/Speedtest.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/Speedtest.bundle

echo "Installing SS-Plex"
sudo git clone https://github.com/mikew/ss-plex.bundle.git
cp -fR /home/xxxusernamexxx/ss-plex.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/ss-plex.bundle

echo "Installing WebTools"
sudo git clone https://github.com/ukdtom/WebTools.bundle.git
cp -fR /home/xxxusernamexxx/WebTools.bundle '/var/lib/plexmediaserver/Library/Application Support/Plex Media Server/Plug-ins/'
rm -r /home/xxxusernamexxx/WebTools.bundle

chown plex:plex -R /var/lib/plexmediaserver
sudo chmod 0777 -R /var/lib/plexmediaserver
systemctl start plexmediaserver
