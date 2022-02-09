#!/bin/bash

#5.1
if [[ $(perl -ne 'print if /^ *<Directory *\//i .. /<\/Directory/i' $APACHE_PREFIX/conf/httpd.conf |grep 'Options None') ]]; then
./check.sh "5.1: Ensure Options for the OS Root Directory Are Restricted" PASS
else
./check.sh "5.1: Ensure Options for the OS Root Directory Are Restricted" FAIL
fi

#5.2
if [[ $(perl -ne 'print if /^ *<Directory *\//i .. /<\/Directory/i' $APACHE_PREFIX/conf/httpd.conf |grep 'Options None') ]]; then
./check.sh "5.2: Ensure Options for the Web Root Directory Are Restricted" PASS
else
./check.sh "5.2: Ensure Options for the Web Root Directory Are Restricted" FAIL
fi

#5.3
if [[ $(perl -ne 'print if /^ *<Directory *\//i .. /<\/Directory/i' $APACHE_PREFIX/conf/httpd.conf |grep 'Options None') ]]; then
./check.sh "5.3: Ensure Options for Other Directories Are Minimized" PASS
else
./check.sh "5.3: Ensure Options for Other Directories Are Minimized" FAIL
fi


