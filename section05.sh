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
if [[ ! $(perl -ne 'print if /^ *<Directory */i .. /<\/Directory/i' $APACHE_PREFIX/conf/httpd.conf |grep -v '^#'|grep Options |grep -v 'Options None') ]]; then
./check.sh "5.3: Ensure Options for Other Directories Are Minimized" PASS
else
./check.sh "5.3: Ensure Options for Other Directories Are Minimized" FAIL
fi

#5.4
./check.sh "5.4: Ensure Default HTML Content Is Removed" MANUAL

#5.5
if [[ $(ls $APACHE_PREFIX/cgi-bin/printenv 2>/dev/null)  ]]; then
./check.sh "5.5: Ensure the Default CGI Content printenv Script Is Removed" FAIL
else
./check.sh "5.5: Ensure the Default CGI Content printenv Script Is Removed" PASS
fi

#5.6
if [[ $(ls $APACHE_PREFIX/cgi-bin/test-cgi 2>/dev/null)  ]]; then
./check.sh "5.6: Ensure the Default CGI Content test-cgi Script Is Removed" FAIL
else
./check.sh "5.6: Ensure the Default CGI Content test-cgi Script Is Removed" PASS
fi

#5.7
./check.sh "5.7: Ensure HTTP Request Methods Are Restricted" MANUAL

#5.8
if [[ $(grep 'TraceEnable off' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "5.8: Ensure the HTTP TRACE Method Is Disabled" PASS
else
./check.sh "5.8: Ensure the HTTP TRACE Method Is Disabled" FAIL
fi

#5.9
./check.sh "5.9: Ensure Old HTTP Protocol Versions Are Disallowed" MANUAL

#5.10
FilesMatch=$(perl -ne 'print if /^ *<FilesMatch "\^\\\.ht/i .. /<\/FilesMatch/i' $APACHE_PREFIX/conf/httpd.conf)
if [[ $FilesMatch == '' ]]; then
./check.sh "5.10: Ensure Access to .ht* Files Is Restricted" FAIL
else
./check.sh "5.10: Ensure Access to .ht* Files Is Restricted" PASS
fi

#5.11
FilesMatch=$(perl -ne 'print if /^ *<FilesMatch "\^\.\*\$/i .. /<\/FilesMatch/i' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null)
FilesMatch2=$(perl -ne 'print if /^ *<FilesMatch "\^\.\*\\\.\(*\)*/i .. /<\/FilesMatch/i' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null)
if [[ "$FilesMatch" == '' || "$FilesMatch2" == '' ]]; then
./check.sh "5.11: Ensure Access to Inappropriate File Extensions Is Restricted" FAIL
else
./check.sh "5.11: Ensure Access to Inappropriate File Extensions Is Restricted" PASS
fi

#5.12
Count=$(grep -e 'RewriteEngine On' -e 'RewriteCond' -e 'RewriteRule' $APACHE_PREFIX/conf/httpd.conf |wc -l)
if [[ $Count != 4 ]]; then
./check.sh "5.12: Ensure IP Address Based Requests Are Disallowed" FAIL
else
./check.sh "5.12: Ensure IP Address Based Requests Are Disallowed" PASS
fi


#5.13
ListenDirectiveCount=$(grep Listen  $APACHE_PREFIX/conf/httpd.conf |grep -v '^#' |wc -l)
ListenDirectivesWithIPs=$(grep Listen  $APACHE_PREFIX/conf/httpd.conf |grep -v '^#' |grep -v '0.0.0.0' |grep -E "([0-9]{1,3}[\.]){3}[0-9]{1,3}" |wc -l)

if [[ $ListenDirectiveCount == $ListenDirectivesWithIPs && $ListenDirectivesWithIPs != 0 ]]; then
./check.sh "5.13: Ensure the IP Addresses for Listening for Requests Are Specified" PASS
else
./check.sh "5.13: Ensure the IP Addresses for Listening for Requests Are Specified" FAIL
fi

#5.14
Var=$(grep -i X-Frame-Options $APACHE_PREFIX/conf/httpd.conf)
if [[ "$Var" != "Header always append X-Frame-Options SAMEORIGIN" ]]; then
./check.sh "5.14: Ensure Browser Framing Is Restricted" FAIL
else
./check.sh "5.14: Ensure Browser Framing Is Restricted" PASS
fi

