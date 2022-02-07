#!/bin/bash
if [[ ! $(grep -i 'ubuntu' /etc/os-release 2>/dev/null) ]]; then
	./check.sh "12.0: Enable AppArmor to Restrict Apache Processes" NOTAPPLICABLE
fi
