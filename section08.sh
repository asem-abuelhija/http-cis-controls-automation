#!/bin/bash


#8.1
## EXACT MATCH SHOULD BE RETURNED (or ProdOnly)
if [[ $(grep 'ServerTokens Prod' $APACHE_PREFIX/conf/httpd.conf) ]]; then 
./check.sh "8.1: Ensure ServerTokens is Set to 'Prod' or 'ProductOnly'" PASS; 
else 
./check.sh "8.1: Ensure ServerTokens is Set to 'Prod' or 'ProductOnly'" FAIL; 
fi

#8.2
## EXACT MATCH SHOULD BE RETURNED
if [[ $(grep 'ServerSignature Off' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "8.2: Ensure ServerSignature Is Not Enabled" PASS;
else
./check.sh "8.2: Ensure ServerSignature Is Not Enabled" FAIL;
fi

#8.3
## NO OUTPUT SHOULD BE RETURNED
if [[ $(grep 'icons' $APACHE_PREFIX/conf/httpd.conf|grep -i 'Alias' |grep -v '^#') ]]; then
./check.sh "8.3: Ensure All Default Apache Content Is Removed'" FAIL;
else
./check.sh "8.3: Ensure All Default Apache Content Is Removed" PASS;
fi

#8.4
## NO OUTPUT SHOULD BE RETURNED
if [[ $(grep 'FileETag' $APACHE_PREFIX/conf/httpd.conf|grep -v '^#'|egrep -i 'all|+inode|inode') ]]; then
./check.sh "8.4: Ensure ETag Response Header Fields Do Not Include Inodes" FAIL;
else
./check.sh "8.4: Ensure ETag Response Header Fields Do Not Include Inodes" PASS;
fi

