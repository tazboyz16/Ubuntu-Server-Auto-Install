#!/bin/bash

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
#will save in /var/spool/cron/crontabs
sudo crontab /opt/install/System/SystemupdateCronjobs.txt
