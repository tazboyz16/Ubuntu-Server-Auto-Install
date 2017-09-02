#!/bin/bash



#install Glances
apt install python-pip python-psutil -y
pip install bernhard bottle cassandra-driver couchdb docker elasticsearch hddtemp influxdb kafka-python matplotlib netifaces nvidia-ml-py3 pika potsdb prometheus_client py-cpuinfo pymdstat pysnmp pystache pyzmq requests scandir statsd wifi zeroconf
