#!/bin/bash

echo "<--- Restoring Hostname and FQ Hostname --->"
cat /home/xxxusernamexxx/install/System/host.txt > /etc/hosts
hostname -f 
sleep 1

echo "<--- Installing iRedMail email--->"
tar xjf /home/xxxusernamexxx/install/Iredmail/iRedMail-*.tar.bz2

cp /home/xxxusernamexxx/install/Iredmail/config /home/xxxusernamexxx/iRedMail-*/

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
#replace relayhost with ISP email outbound server
echo "relayhost = smtp-server.xxx.rr.com" >> /etc/postfix/main.cf
cat /home/xxxusernamexxx/install/Iredmail/iptables.rules > /etc/default/iptables
