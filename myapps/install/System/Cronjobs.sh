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

#Run updates on Mondays at 530am

#* * * * * "command to be executed"
#- - - - -
#| | | | |
#| | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
#| | | ------- Month (1 - 12)
#| | --------- Day of month (1 - 31)
#| ----------- Hour (0 - 23)
#------------- Minute (0 - 59)

# create a cronjob for system updates daily and full system updates Monthly with reboot


echo "Adding CronJobs for Update System daily and monthly"

echo "#weekly on Mondays
15 5 * * 1 root sudo bash /opt/Systemupdate.sh -w
" > /etc/cron.d/WeeklyUpdate

echo "#monthly on 1st of every month
15 4 1 * * root sudo bash /opt/Systemupdate.sh -m
" > /etc/cron.d/MonthlyUpdate

echo "#weekly Reboot
0 4 * * 1 root sudo reboot
" > /etc/cron.d/WeeklyReboot

echo "#IP Address Update 
*/5 * *	* *	root sudo bash /opt/IpAddressupdate.sh
" > /etc/cron.d/IpUpdate


echo "#IP Address Update 
*/5 * *	* *	root sudo bash /opt/IpAddressupdate.sh" > /etc/cron.d/IpUpdate
