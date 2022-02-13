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

#6.3
if [[ $(grep '^CustomLog' $APACHE_PREFIX/conf/httpd.conf) || $(grep '^LogFormat' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "6.3: Ensure the Server Access Log Is Configured Correctly" PASS
else
./check.sh "6.3: Ensure the Server Access Log Is Configured Correctly" FAIL
fi

#6.4
./check.sh "6.4: Ensure Log Storage and Rotation Is Configured Correctly" MANUAL

#6.5
./check.sh "6.5: Ensure Applicable Patches Are Applied" MANUAL

#6.6
if [[ $(grep 'security2_module' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "6.6: Ensure ModSecurity Is Installed and Enabled" PASS
else
./check.sh "6.6: Ensure ModSecurity Is Installed and Enabled" FAIL
fi

#6.7
OWASP=$(find $APACHE_PREFIX/modsecurity.d/activated_rules/ -name 'modsecurity_crs_*.conf' 2>/dev/null| xargs grep '^SecRule ' | wc -l)
if [[ $OWASP -ge 200 ]]; then
./check.sh "6.7: Ensure the OWASP ModSecurity Core Rule Set Is Installed and Enabled" PASS
elif [[ $OS != 'Linux' ]]; then
./check.sh "6.7: Ensure the OWASP ModSecurity Core Rule Set Is Installed and Enabled" NOTAPPLICABLE
else
./check.sh "6.7: Ensure the OWASP ModSecurity Core Rule Set Is Installed and Enabled" FAIL
fi

