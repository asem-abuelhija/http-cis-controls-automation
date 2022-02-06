#!/bin/bash
#LimitRequestLine=$(grep 'LimitRequestLine' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null)
#echo $LimitRequestLine
#10.1
if [[ ! $(grep 'LimitRequestLine' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.1: Ensure the LimitRequestLine directive is Set to 512 or less" FAIL;
fi

#10.1
if [[ ! $(grep 'LimitRequestFields' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.2: Ensure the LimitRequestFields Directive is Set to 100 or Less" FAIL;
fi

#10.1
if [[ ! $(grep 'LimitRequestFieldsize' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.3: Ensure the LimitRequestFieldsize Directive is Set to 1024 or Less" FAIL;
fi

#10.1
if [[ ! $(grep 'LimitRequestBody' $APACHE_PREFIX/conf/httpd.conf) ]]; then ## 512 or less
./check.sh "10.4: Ensure the LimitRequestBody Directive is Set to 102400 or Less" FAIL;
fi

