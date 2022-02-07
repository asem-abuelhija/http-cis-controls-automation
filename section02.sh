#!/bin/bash
CYAN='\033[1;36m'
NC='\033[0m'

#2.1
echo -e "2.1: Ensure Only Necessary Authentication and Authorization Modules Are Enabled ===> ${CYAN}Not Scored${NC}"

#2.2
Output=$(grep 'log_config' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null)
if [[ $Output == 'LoadModule log_config_module modules/mod_log_config.so' ]]; then
./check.sh "2.2: Ensure the Log Config Module Is Enabled" PASS
else
./check.sh "2.2: Ensure the Log Config Module Is Enabled" FAIL
fi

#2.3
Output=$(grep 'dav_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.3: Ensure the WebDAV Modules Are Disabled" PASS
else
./check.sh "2.3: Ensure the WebDAV Modules Are Disabled" FAIL
fi

#2.4
Output=$(grep 'status_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.4: Ensure the Status Module Is Disabled" PASS
else
./check.sh "2.4: Ensure the Status Module Is Disabled" FAIL
fi

#2.5
Output=$(grep 'autoindex_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.5: Ensure the Autoindex Module Is Disabled" PASS
else
./check.sh "2.5: Ensure the Autoindex Module Is Disabled" FAIL
fi

#2.6
Output=$(grep 'proxy_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.6: Ensure the Proxy Modules Are Disabled" PASS
else
./check.sh "2.6: Ensure the Proxy Modules Are Disabled" FAIL
fi

#2.7
Output=$(grep 'userdir_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.7: Ensure the User Directories Module Is Disabled" PASS
else
./check.sh "2.7: Ensure the User Directories Module Is Disabled" FAIL
fi

#2.8
Output=$(grep 'info_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.8: Ensure the Info Module Is Disabled" PASS
else
./check.sh "2.8: Ensure the Info Module Is Disabled" FAIL
fi

#2.9
Output=$(grep 'auth_' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep -v "^#")
if [[ $Output == '' ]]; then
./check.sh "2.9: Ensure the Basic and Digest Authentication Modules are Disabled" PASS
else
./check.sh "2.9: Ensure the Basic and Digest Authentication Modules are Disabled" FAIL
fi
