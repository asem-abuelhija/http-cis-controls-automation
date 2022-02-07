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

