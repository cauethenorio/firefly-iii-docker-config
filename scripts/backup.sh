#!/usr/bin/env bash

set -e

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
TARGET="./backups/firefly-data-backup-${NOW}.tar.gz"

RUNNING_CONTAINERS=$(echo $(docker-compose ps -q | wc -l))

if (( $RUNNING_CONTAINERS > 0 )); then
  make down
fi

echo "Creating..."

./scripts/save-images-digests.sh

mkdir -p ./backups
tar czf ${TARGET} ./generated_data

echo "Created: ${TARGET}"

if (( $RUNNING_CONTAINERS > 0 )); then
  make up
fi
