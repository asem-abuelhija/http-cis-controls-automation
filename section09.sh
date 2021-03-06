#!/bin/bash


#9.1
if [[ ! $(grep '^Timeout' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "9.1: Ensure the TimeOut Is Set to 10 or Less" FAIL;
else
Timeout=$(grep '^Timeout' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=10-$Timeout
if [[ $value -ge 0 ]]; then
./check.sh "9.1: Ensure the TimeOut Is Set to 10 or Less" PASS;
else
./check.sh "9.1: Ensure the TimeOut Is Set to 10 or Less" FAIL;
fi
fi

#9.2
if [[ ! $(grep '^KeepAlive On' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "9.2: Ensure KeepAlive Is Enabled" FAIL;
else
./check.sh "9.2: Ensure KeepAlive Is Enabled" PASS;
fi

#9.3
if [[ ! $(grep '^MaxKeepAliveRequests' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "9.3: Ensure MaxKeepAliveRequests is Set to a Value of 100 or Greater" FAIL;
else
MaxKeepAliveRequests=$(grep '^MaxKeepAliveRequests' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=$MaxKeepAliveRequests-100
if [[ $value -ge 0 ]]; then
./check.sh "9.3: Ensure MaxKeepAliveRequests is Set to a Value of 100 or Greater" PASS;
else
./check.sh "9.3: Ensure MaxKeepAliveRequests is Set to a Value of 100 or Greater" FAIL;
fi
fi

#9.4
if [[ ! $(grep '^KeepAliveTimeout' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "9.4: Ensure KeepAliveTimeout is Set to a Value of 15 or Less" FAIL;
else
KeepAliveTimeout=$(grep '^KeepAliveTimeout' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=15-$KeepAliveTimeout
if [[ $value -ge 0 ]]; then
./check.sh "9.4: Ensure KeepAliveTimeout is Set to a Value of 15 or Less" PASS;
else
./check.sh "9.4: Ensure KeepAliveTimeout is Set to a Value of 15 or Less" FAIL;
fi
fi
#9.5
if [[ $( grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| grep "reqtimeout_module") ]]; then
./check.sh "9.5: Ensure the Timeout Limits for Request Headers is Set to 40 or Less" PASS
else
	if [[ $(grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf| grep 'RequestReadTimeout'  2>/dev/null) ]]; then
		headerMax=$(grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| grep 'RequestReadTimeout'|grep -o ' header=[0-9]*-[0-9]*'| cut -d '-' -f2 2>/dev/null)
		if [[ $headerMax -le 40 ]]; then 
		./check.sh "9.5: Ensure the Timeout Limits for Request Headers is Set to 40 or Less" PASS;
		else
		./check.sh "9.5: Ensure the Timeout Limits for Request Headers is Set to 40 or Less" FAIL;
		fi
	else
        ./check.sh "9.5: Ensure the Timeout Limits for Request Headers is Set to 40 or Less" FAIL;
        fi
fi

#9.6
if [[ $( grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| grep "reqtimeout_module") ]]; then
./check.sh "9.5: Ensure the Timeout Limits for Request Headers is Set to 40 or Less" PASS
else
	if [[ $(grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf| grep 'RequestReadTimeout'  2>/dev/null) ]]; then
        	headerMax=$(grep -v '^#'  $APACHE_PREFIX/conf/httpd.conf| grep 'RequestReadTimeout'|grep -o ' body=[0-9]*'| cut -d '=' -f2 2>/dev/null)
        	if [[ $headerMax -le 40 ]]; then
        	./check.sh "9.6: Ensure Timeout Limits for the Request Body is Set to 20 or Less" PASS
        	else
        	./check.sh "9.6: Ensure Timeout Limits for the Request Body is Set to 20 or Less" FAIL
        	fi
	else
	./check.sh "9.6: Ensure Timeout Limits for the Request Body is Set to 20 or Less" FAIL
	fi
fi
