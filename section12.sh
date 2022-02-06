#!/bin/bash
CYAN='\033[1;36m'
NC='\033[0m'
if [[ ! $(grep -i 'ubuntu' /etc/os-release 2>/dev/null) ]]; then
	echo -e "12: Enable AppArmor to Restrict Apache Processes ==> ${CYAN}Not Applicable ${NC} (Not Ubuntu)"
fi
