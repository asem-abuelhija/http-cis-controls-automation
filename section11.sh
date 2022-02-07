#!/bin/bash
if [[ ! $(grep -i 'red hat' /etc/os-release 2>/dev/null) ]]; then
	./check.sh "11.0: Enable SELinux to Restrict Apache Processes" NOTAPPLICABLE
fi
