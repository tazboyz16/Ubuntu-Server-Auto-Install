apt-key adv --keyserver keyserver.ubuntu.com --recv-key FDC247B7
echo 'deb https://repo.windscribe.com/ubuntu zesty main' | sudo tee /etc/apt/sources.list.d/windscribe-repo.list
apt update
apt install windscribe-cli -y
windscribe login
windscribe connect

windscribe --help
### its under beta
#requires openvpn installed
#https://forum.htpcguides.com/Thread-VPN-Split-Tunneling-problem
