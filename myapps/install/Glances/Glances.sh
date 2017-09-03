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

#install Glances
#run glances with glances -w for WEB GUI
apt install python-pip -y
pip install bernhard bottle
pip install cassandra-driver couchdb
pip install docker elasticsearch
pip install hddtemp influxdb
pip install kafka-python matplotlib
pip install netifaces nvidia-ml-py3
pip install pika potsdb
pip install prometheus_client py-cpuinfo
pip install pymdstat pysnmp
pip install pystache pyzmq
pip install requests scandir
pip install statsd wifi zeroconf
pip install glances
