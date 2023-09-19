#!/bin/bash
CURRENT=$(kubectl config get-contexts | grep "*" | awk '{ print $2 }')
printf "## Current Kube Profile\n# ${CURRENT} \n##\n\n"

ENTITIES=$(kubectl config get-contexts --no-headers --output='name')
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
  kubectl config use-context ${choiche}
fi
