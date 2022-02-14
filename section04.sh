#!/bin/bash

ROOTDIR=$(perl -ne 'print if /^ *<Directory *\//i .. /<\/Directory/i' $APACHE_PREFIX/conf/httpd.conf)

#4.1
if [[ $(echo $ROOTDIR |grep -e 'Order deny,allow' -e 'Deny from all') ]]; then
./check.sh "4.1: Ensure Access to OS Root Directory Is Denied By Default" PASS
else 
./check.sh "4.1: Ensure Access to OS Root Directory Is Denied By Default" FAIL
fi

#4.2
./check.sh "4.2: Ensure Appropriate Access to Web Content Is Allowed" NOTSCORED

#4.3
if [[ $(echo $ROOTDIR |grep -e 'AllowOverride None') ]]; then
./check.sh "4.3: Ensure OverRide Is Disabled for the OS Root Directory" PASS
else
./check.sh "4.3: Ensure OverRide Is Disabled for the OS Root Directory" FAIL
fi

#4.4

if [[ ! $(grep -i AllowOverride $APACHE_PREFIX/conf/httpd.conf |grep -v '^#'| grep -v 'AllowOverride None') ]]; then
./check.sh "4.4: Ensure OverRide Is Disabled for All Directories" PASS
else
./check.sh "4.4: Ensure OverRide Is Disabled for All Directories" FAIL
fi
