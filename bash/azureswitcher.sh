#!/bin/bash

###
# This has limitations with spaces in names.
###

ENTITIES=$(az account list -o tsv | awk '{ print $6}')
SELECTION=1

while read -r line; do
  echo "$SELECTION) $line"
  ((SELECTION++))
done <<< "$ENTITIES"

((SELECTION--))

echo
printf 'Select an entity from the above list: '
read -r opt

if [[ `seq 1 $SELECTION` =~ $opt ]]; then
  choiche=$(sed -n "${opt}p" <<< "$ENTITIES")
   az account set -s ${choiche}
   az account list -o table | grep True
fi

