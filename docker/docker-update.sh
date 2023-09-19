#!/bin/bash

dockerfolders=("esphome" "homeassistant" "mosquitto" "wireguard" "z2m")
base_dir="/opt/docker/"
currentDate=$(date)

echo "Script start"
echo "========================================="
echo "${currentDate}"
echo "========================================="
# Loop over the list and do a docker image pull.
for F in "${dockerfolders[@]}"; do
	echo "Docker update of ${F} - BEGIN"
	echo "========================================="
	cd ${base_dir}${F}
	docker compose pull && docker compose up -d
	echo "========================================="
	echo "Docker update of ${F} - END"
	echo "========================================="
done
echo "Clean up"
docker system prune --all -f
echo "script end"
