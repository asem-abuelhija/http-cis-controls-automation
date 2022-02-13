#!/bin/bash

#6.1
if [[ $(grep 'LogLevel' $APACHE_PREFIX/conf/httpd.conf|egrep 'notice|info|debug' 2>/dev/null) && $(grep '^ErrorLog' $APACHE_PREFIX/conf/httpd.conf) ]]; then 
./check.sh "6.1: Ensure the Error Log Filename and Severity Level Are Configured Correctly" PASS
else
./check.sh "6.1: Ensure the Error Log Filename and Severity Level Are Configured Correctly" FAIL
fi

#6.2
if [[ $(grep 'ErrorLog "syslog:' $APACHE_PREFIX/conf/httpd.conf)  ]]; then
./check.sh "6.2: Ensure a Syslog Facility Is Configured for Error Logging" PASS
else
./check.sh "6.2: Ensure a Syslog Facility Is Configured for Error Logging" FAIL
fi
