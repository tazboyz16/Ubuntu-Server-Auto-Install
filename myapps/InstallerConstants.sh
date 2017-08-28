#!/bin/bash

###########################################################
# Created by @tazboyz16 
# This Script was created at 
# https://github.com/tazboyz16/Ubuntu-Server-Auto-Install
# @ 2017 Copyright
# GNU General Public License v3.0
###########################################################

# source this file in the installers to keep constant info across installs

#if you need a random password to be created use for Example:
#RandomSalt=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8})
#to increase the Charaters of the password change the 8 to size you would perfer

SystemAdmin=
Domain=
SambaUsername=
SambaPassword=
TimeZone=

#Apache2 settings
AdminEmail=

#MySql settings
PhpMyAdminSqlPassword=
PMAappPassword=
PMAadminPassword=

#** I Recommend Root to be create with a random Password for Security **
MySqlRootPasword=

#Phpmyadmin login Secure
phpadmin=xxxusernamexxx
phppassword=xxxphppasswordxxx

#Mysql Admin account for root is disabled
mysqladmin=xxxsqlxxx
mysqlpassword=xxxsqlpassxxx

#iredmail settings
