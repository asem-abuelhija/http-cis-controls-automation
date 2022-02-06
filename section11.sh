#!/bin/bash
CYAN='\033[1;36m'
NC='\033[0m'
if [[ ! $(grep -i 'red hat' /etc/os-release) ]]; then
	echo -e "11: Enable SELinux to Restrict Apache Processes ===> ${CYAN}Not Applicable ${NC} (Not Red Hat)"
fi
