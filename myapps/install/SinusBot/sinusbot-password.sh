#!/bin/bash

echo "Reseting Sinusbot Service back to normal operations"
 
sytemctl stop sinusbot
sed -i 's/ -pwreset=foobar/ /g' /etc/systemd/system/sinusbot.service
systemctl daemon-reload
systemctl restart sinusbot
