#!/bin/bash
CYAN='\033[1;36m'
NC='\033[0m'

./check.sh "1.1: Ensure the Pre-Installation Planning Checklist Has Been Implemented" NOTSCORED
./check.sh "1.2: Ensure the Server Is Not a Multi-Use System" NOTSCORED
./check.sh "1.3: Ensure Apache Is Installed From the Appropriate Binaries" NOTSCORED

