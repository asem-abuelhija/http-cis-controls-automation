#!/bin/bash

#3.1
if [[ !  $(egrep -i '^User |^Group ' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |awk '{print $2}' |egrep -v 'root|nobody|daemon') ]]; then
./check.sh "3.1: Ensure the Apache Web Server Runs As a Non-Root User" FAIL
else
./check.sh "3.1: Ensure the Apache Web Server Runs As a Non-Root User" PASS
fi

#3.2
shell=$(grep apache /etc/passwd |awk -F ":" '{print $NF}' |awk -F "/" '{print $NF}')
if [[ $shell == 'false' || $shell == 'nologin' ]]; then
./check.sh "3.2: Ensure the Apache User Account Has an Invalid Shell" PASS
else
./check.sh "3.2: Ensure the Apache User Account Has an Invalid Shell" FAIL
fi 

#3.3
if [[ $(passwd -S apache 2>/dev/null|grep 'Password locked') ]]; then 
./check.sh "3.3: Ensure the Apache User Account Is Locked" PASS
else
./check.sh "3.3: Ensure the Apache User Account Is Locked" FAIL
fi

#3.4
linecount=$(find $APACHE_PREFIX \! -user root -ls |wc -l)
if [[ $linecount != 0 ]]; then
./check.sh "3.4: Ensure Apache Directories and Files Are Owned By Root" FAIL
else
./check.sh "3.4: Ensure Apache Directories and Files Are Owned By Root" PASS
fi

#3.5
linecount=$(find $APACHE_PREFIX -path $APACHE_PREFIX/htdocs -prune -o \! -group root -ls |wc -l)
if [[ $linecount != 0 ]]; then
./check.sh "3.5: Ensure the Group Is Set Correctly on Apache Directories and Files" FAIL
else
./check.sh "3.5: Ensure the Group Is Set Correctly on Apache Directories and Files" PASS
fi

#3.6
linecount=$(find -L $APACHE_PREFIX \! -type l -perm /o=w -ls |wc -l)
if [[ $linecount != 0 ]]; then
./check.sh "3.6: Ensure Other Write Access on Apache Directories and Files Is Restricted" FAIL
else
./check.sh "3.6: Ensure Other Write Access on Apache Directories and Files Is Restricted" PASS
fi

#3.7
if [[ ! $(grep CoreDumpDirectory $APACHE_PREFIX/conf/httpd.conf | grep -v "^#") ]]; then
./check.sh "3.7: Ensure the Core Dump Directory Is Secured" PASS
else
./check.sh "3.7: Ensure the Core Dump Directory Is Secured" MANUAL
fi

#3.8
if [[ ! $(grep LockFile $APACHE_PREFIX/conf/httpd.conf | grep -v "^#") ]]; then
./check.sh "3.8: Ensure the Lock File Is Secured" PASS
else
./check.sh "3.8: Ensure the Lock File Is Secured" MANUAL
fi

#3.9
if [[ ! $(grep PidFile $APACHE_PREFIX/conf/httpd.conf | grep -v "^#") ]]; then
./check.sh "3.9: Ensure the Pid File Is Secured" PASS
else
./check.sh "3.9: Ensure the Pid File Is Secured" MANUAL
fi

#3.10
if [[ ! $(grep ScoreBoardFile $APACHE_PREFIX/conf/httpd.conf | grep -v "^#") ]]; then
./check.sh "3.10: Ensure the ScoreBoard File Is Secured" PASS
else
./check.sh "3.10: Ensure the ScoreBoard File Is Secured" MANUAL
fi

#3.11
linecount=$(find -L $APACHE_PREFIX \! -type l -perm /g=w -ls |wc -l)
if [[ $linecount != 0 ]]; then
./check.sh "3.11: Ensure Group Write Access for the Apache Directories and Files Is Properly Restricted" FAIL
else
./check.sh "3.11: Ensure Group Write Access for the Apache Directories and Files Is Properly Restricted" PASS
fi

#3.12
linecount=$(find -L $DOCROOT \! -type l -perm /g=w -ls |wc -l)
if [[ $linecount != 0 ]]; then
./check.sh "3.12: Ensure Group Write Access for the Document Root Directories and Files Is Properly Restricted" FAIL
else
./check.sh "3.12: Ensure Group Write Access for the Document Root Directories and Files Is Properly Restricted" PASS
fi


#3.13
./check.sh "3.13: Ensure Access to Special Purpose Application Writable Directories is Properly Restricted" NOTSCORED
