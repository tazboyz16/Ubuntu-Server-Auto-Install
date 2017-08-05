#!/bin/bash

apt update
apt install python python-pip
pip install noipy

#to create auth config file to service
noipy --store -u xxxusernamxxx -p xxxpasswordxxx -n xxxdomainxxx --provider generic --url https://api.dynu.com IP_ADDRESS

#to run update
noipy -n xxxdomainxxx --url https://api.dynu.com
