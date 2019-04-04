#!/usr/bin/env bash

set -e

NOW=$(date +"%Y-%m-%d-%H-%M-%S")
TARGET="./backups/firefly-data-backup-${NOW}.tar.gz"

echo "Creating..."

./scripts/save-images-digests.sh

mkdir -p ./backups
tar czf ${TARGET} ./generated_data

echo "Created: ${TARGET}"
