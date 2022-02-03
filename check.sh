#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'


if [[ $2 == 'PASS' ]] ; then
echo -e "$1 ===> ${GREEN}PASS${NC}"
fi

if [[ $2 == 'FAIL' ]] ; then
echo -e "$1 ===> ${RED}FAIL${NC}"
fi
