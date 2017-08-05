#!/bin/bash

apt update
apt install python python-pip
pip install noipy

#to create auth config file to service
noipy --store -u tazboyz16 -p rg325odn -n tazserver.ga --provider generic --url https://api.dynu.com IP_ADDRESS

#to run update
noipy -n tazserver.ga --url https://api.dynu.com
