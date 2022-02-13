#!/bin/bash
#7.1
if [[ $(grep -e 'mod_ssl' -e 'mod_nss' -e 'ibm_ssl_module' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "7.1: Ensure mod_ssl and/or mod_nss Is Installed" PASS
else
./check.sh "7.1: Ensure mod_ssl and/or mod_nss Is Installed" FAIL
fi 

#7.2
./check.sh "7.2: Ensure a Valid Trusted Certificate Is Installed" MANUAL

#7.3
if [[ $(grep SSLCertificateFile $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "7.3: Ensure the Server's Private Key Is Protected" PASS
else
./check.sh "7.3: Ensure the Server's Private Key Is Protected" FAIL
fi

#7.4
if [[ $OS == 'Linux' ]]; then
	if [[ $(grep 'SSLProtocol TLS1.2' $APACHE_PREFIX/conf/httpd.conf) ]]; then
	./check.sh "7.4: Ensure the TLSv1.0 and TLSv1.1 Protocols are Disabled" PASS
	else
	./check.sh "7.4: Ensure the TLSv1.0 and TLSv1.1 Protocols are Disabled" FAIL
	fi
elif [[ $OS == 'AIX' ]]; then
	if [[ $(grep 'SSLProtocolDisable' $APACHE_PREFIX/conf/httpd.conf) ]]; then
        ./check.sh "7.4: Ensure the TLSv1.0 and TLSv1.1 Protocols are Disabled" PASS
        else
        ./check.sh "7.4: Ensure the TLSv1.0 and TLSv1.1 Protocols are Disabled" FAIL
        fi
fi

#7.5
if [[ $(grep 'SSLHonorCipherOrder On' $APACHE_PREFIX/conf/httpd.conf) && $(grep 'SSLCipherSuite' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "7.5: Ensure Weak SSL/TLS Ciphers Are Disabled" PASS
else
./check.sh "7.5: Ensure Weak SSL/TLS Ciphers Are Disabled" FAIL
fi

#7.6
count=$(grep 'SSLInsecureRenegotiation' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |wc -l)
if [[ $(grep 'SSLInsecureRenegotiation off' $APACHE_PREFIX/conf/httpd.conf) || count == 0 ]]; then
./check.sh "7.6: Ensure Insecure SSL Renegotiation Is Not Enabled" PASS
else
./check.sh "7.6: Ensure Insecure SSL Renegotiation Is Not Enabled" FAIL
fi

#7.7
count=$(grep 'SSLCompression'  $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |wc -l)
if [[ $(grep 'SSLCompression off' $APACHE_PREFIX/conf/httpd.conf) || count == 0 ]]; then
./check.sh "7.7: Ensure SSL Compression is not Enabled" PASS
else
./check.sh "7.7: Ensure SSL Compression is not Enabled" FAIL
fi

#7.8
if [[ $(grep 'SSLCipherSuite' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| grep '!3DES') && $(grep 'SSLCipherSuite' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null| grep '!IDEA') ]]; then
./check.sh "7.8: Ensure Medium Strength SSL/TLS Ciphers Are Disabled" PASS
else
./check.sh "7.8: Ensure Medium Strength SSL/TLS Ciphers Are Disabled" FAIL
fi

#7.9
if [[ $( grep '^Redirect' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "7.9: Ensure All Web Content is Accessed via HTTPS" PASS
else
./check.sh "7.9: Ensure All Web Content is Accessed via HTTPS" FAIL
fi

#7.10
./check.sh "7.10: Ensure OCSP Stapling Is Enabled" PASS
#7.11
MaxAge=$(grep -v '^#' $APACHE_PREFIX/conf/httpd.conf 2>/dev/null |grep Strict-Transport-Security |grep -o 'max-age=[0-9]*'| cut -d '=' -f2 2>/dev/null)
if [[ $MaxAge -ge 480 ]]; then
./check.sh "7.11: Ensure HTTP Strict Transport Security Is Enabled" PASS
else
./check.sh "7.11: Ensure HTTP Strict Transport Security Is Enabled" FAIL
fi

#7.12
if [[ $(grep 'SSLCipherSuite' $APACHE_PREFIX/conf/httpd.conf) ]]; then
./check.sh "7.12: Ensure Only Cipher Suites That Provide Forward Secrecy Are Enabled" PASS
else
./check.sh "7.12: Ensure Only Cipher Suites That Provide Forward Secrecy Are Enabled" FAIL
fi
