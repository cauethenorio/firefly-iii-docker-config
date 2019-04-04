#!/usr/bin/env bash

set -e

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
TARGET="./backups/firefly-data-backup-${NOW}.tar.gz"

RUNNING_CONTAINERS=$(echo $(docker-compose ps -q | wc -l))

if (( $RUNNING_CONTAINERS > 0 )); then
  docker-compose stop
fi

echo "Creating..."

cp ".app-env" ./generated_data

mkdir -p ./backups
tar czf ${TARGET} ./generated_data

rm "./generated_data/.app-env"

echo "Created: ${TARGET}"

if (( $RUNNING_CONTAINERS > 0 )); then
  docker-compose start
fi
