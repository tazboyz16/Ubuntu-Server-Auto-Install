#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "This Script must be run as root"
	exit 1
fi

#Update to Latest Version
iRedMailVer=0.9.7

echo "<--- Restoring Hostname and FQ Hostname --->"
cat /opt/install/System/host.txt > /etc/hosts
hostname -f 
sleep 1

echo "<--- Downloading Latest IredMail Version --->"
cd /opt
sudo wget https://bitbucket.org/zhb/iredmail/downloads/iRedMail-$iRedMailVer.tar.bz2

echo "<--- Installing iRedMail email--->"
tar xjf /opt/iRedMail-$iRedMailVer.tar.bz2

cp /opt/install/Iredmail/config /opt/iRedMail-$iRedMailVer/

AUTO_USE_EXISTING_CONFIG_FILE=y \
    AUTO_INSTALL_WITHOUT_CONFIRM=y \
    AUTO_CLEANUP_REMOVE_SENDMAIL=y \
    AUTO_CLEANUP_REMOVE_MOD_PYTHON=y \
    AUTO_CLEANUP_REPLACE_FIREWALL_RULES=y \
    AUTO_CLEANUP_RESTART_IPTABLES=y \
    AUTO_CLEANUP_REPLACE_MYSQL_CONFIG=y \
    AUTO_CLEANUP_RESTART_POSTFIX=n \
    bash /opt/iRedMail-*/iRedMail.sh

echo "Adding Relay to PostFix"
echo "relayhost = smtp-server.rochester.rr.com" >> /etc/postfix/main.cf
cat /opt/install/Iredmail/iptables.rules > /etc/default/iptables
