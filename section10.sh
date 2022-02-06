#!/bin/bash


#10.1
if [[ ! $(grep 'LimitRequestLine' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.1: Ensure the LimitRequestLine directive is Set to 512 or less" FAIL;
else
LimitRequestLine=$(grep 'LimitRequestLine' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=512-$LimitRequestLine
if [[ $value -ge 0 ]]; then
./check.sh "10.1: Ensure the LimitRequestLine directive is Set to 512 or less" PASS;
else
./check.sh "10.1: Ensure the LimitRequestLine directive is Set to 512 or less" FAIL;
fi
fi


#10.2
if [[ ! $(grep 'LimitRequestFields' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.2: Ensure the LimitRequestFields Directive is Set to 100 or Less" FAIL;
else
LimitRequestFields=$(grep 'LimitRequestFields' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=100-$LimitRequestFields
if [[ $value -ge 0 ]]; then
./check.sh "10.2: Ensure the LimitRequestFields Directive is Set to 100 or Less" PASS;
else
./check.sh "10.2: Ensure the LimitRequestFields Directive is Set to 100 or Less" FAIL;
fi
fi

#10.3
if [[ ! $(grep 'LimitRequestFieldsize' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.3: Ensure the LimitRequestFieldsize Directive is Set to 1024 or Less" FAIL;
else
LimitRequestFieldsize=$(grep 'LimitRequestFieldsize' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=1024-$LimitRequestFieldsize
if [[ $value -ge 0 ]]; then
./check.sh "10.3: Ensure the LimitRequestFieldsize Directive is Set to 1024 or Less" PASS;
else
./check.sh "10.3: Ensure the LimitRequestFieldsize Directive is Set to 1024 or Less" FAIL;
fi
fi

#10.4
if [[ ! $(grep 'LimitRequestBody' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.4: Ensure the LimitRequestBody Directive is Set to 102400 or Less" FAIL;
else
LimitRequestBody=$(grep 'LimitRequestBody' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| awk '{print $2}')
let value=102400-$LimitRequestBody
if [[ $value -ge 0 ]]; then
./check.sh "10.4: Ensure the LimitRequestBody Directive is Set to 102400 or Less" PASS;
else
./check.sh "10.4: Ensure the LimitRequestBody Directive is Set to 102400 or Less" FAIL;
fi
fi

