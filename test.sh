#!/bin/bash
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
BLANK="\033[0m"


VERSION=test-2.0.0
inputs=test

VERSION=${VERSION//${inputs}-/ }

echo $VERSION


VERSION=$(echo "$VERSION" | sed 's/v/ /g')


ver=($(echo "$VERSION" | sed 's/\./ /g'))

# ver=( ${VERSION//./ } )

echo $ver
echo ${ver[0]}.${ver[1]}.${ver[2]}
