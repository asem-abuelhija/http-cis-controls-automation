#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
BIPurple='\033[1;95m'
CYAN='\033[1;36m'

if [ ${#1} -gt 60 ]; then
	STR62="${1:0:60}.."
else
	STR62="${1}                                                                                  "
	STR62="${STR62:0:62}"
fi


if [[ $2 == 'PASS' ]] ; then
echo -e "$STR62 ===> ${GREEN}PASS${NC}"
fi

if [[ $2 == 'FAIL' ]] ; then
echo -e "$STR62 ===> ${RED}FAIL${NC}"
fi

if [[ $2 == 'MANUAL' ]] ; then
echo -e "$STR62 ===> ${BIPurple}Manual Check${NC}"
fi

if [[ $2 == 'NOTSCORED' ]] ; then
echo -e "$STR62 ===> ${CYAN}Not Scored${NC}"
fi

