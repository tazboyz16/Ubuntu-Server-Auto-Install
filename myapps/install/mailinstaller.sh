#!/bin/bash

echo "<--- Restoring Hostname and FQ Hostname --->"
cat /home/xxxusernamexxx/install/configs/host.txt > /etc/hosts
hostname -f 
sleep 1

echo "<--- Installing iRedMail email--->"
tar xjf /home/xxxusernamexxx/install/iRedMail-*.tar.bz2

cp /home/xxxusernamexxx/install/configs/iredmail/config /home/xxxusernamexxx/iRedMail-*/

AUTO_USE_EXISTING_CONFIG_FILE=y \
    AUTO_INSTALL_WITHOUT_CONFIRM=y \
    AUTO_CLEANUP_REMOVE_SENDMAIL=y \
    AUTO_CLEANUP_REMOVE_MOD_PYTHON=y \
    AUTO_CLEANUP_REPLACE_FIREWALL_RULES=y \
    AUTO_CLEANUP_RESTART_IPTABLES=y \
    AUTO_CLEANUP_REPLACE_MYSQL_CONFIG=y \
    AUTO_CLEANUP_RESTART_POSTFIX=n \
    bash /home/xxxusernamexxx/iRedMail-*/iRedMail.sh

echo "Adding Relay to PostFix"
#For the relayhost use the smtp server Your ISP provides 
echo "relayhost = smtp-server.rochester.rr.com" >> /etc/postfix/main.cf
cat /home/xxxusernamexxx/install/configs/iredmail/iptables.rules > /etc/default/iptables
