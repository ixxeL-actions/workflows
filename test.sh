#!/bin/bash
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
PURPLE="\033[1;35m"
CYAN="\033[1;36m"
BLANK="\033[0m"


# VERSION=test-2.0.0
# inputs=test

# VERSION=${VERSION//${inputs}-/ }

# echo $VERSION


# VERSION=$(echo "$VERSION" | sed 's/v/ /g')


# # ver=($(echo "$VERSION" | sed 's/\./ /g'))
# # mapfile -t ver < <(echo "$VERSION" | sed 's/\./ /g')
# IFS=' ' read -r -a ver <<< "$(echo "$VERSION" | sed 's/\./ /g')"


# # ver=( ${VERSION//./ } )

# echo $ver
# echo ${ver[0]}.${ver[1]}.${ver[2]}

        declare -A changed_files
        declare -a uniq_components
        changed_files=$(gh pr view ${PR_NUMBER} --json files --jq '.files.[].path')
        IFS=$'\n' read -rd '' -a files_array <<<"$changed_files"

        for file in "${files_array[@]}"
        do
          echo -e "${CYAN}[ INFO ] > Changed path is ${YELLOW}${file}${BLANK}"
          COMPONENT_NAME=$(echo ${file} | awk -F'/' -v nb="3" '{print $nb}')
          if [[ "$COMPONENT_NAME" != ".github" ]]; then
            if [[ ! " ${uniq_components[@]} " =~ " $COMPONENT_NAME " ]]; then
              uniq_components+=("$COMPONENT_NAME")
            fi
          fi
        done

        if [[ ${#uniq_components[@]} -gt 0 ]]; then
          echo -e "${CYAN}[ INFO ] > Component name is ${YELLOW}${uniq_components[0]}${BLANK}"
          echo "COMPONENT_NAME=${uniq_components[0]}"
          exit 0
        else
          echo -e "${RED}[ ERROR ] > Error, component not found${BLANK}"
          exit 1
        fi
