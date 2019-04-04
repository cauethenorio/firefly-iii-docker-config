#!/usr/bin/env bash

APP_IMAGE="jc5x/firefly-iii:latest"
DB_IMAGE="postgres:10"

LOCKED_IMAGES_DIGESTS_FILE="generated_data/locked_images_digests.sh"

if [ -f "${LOCKED_IMAGES_DIGESTS_FILE}" ]; then
    exit
fi

echo "Creating images digest lock file..."

APP_IMAGE_DIGEST=$(docker image inspect ${APP_IMAGE} -f '{{index .RepoDigests 0}}')
DB_IMAGE_DIGEST=$(docker image inspect ${DB_IMAGE} -f '{{index .RepoDigests 0}}')

echo "export LOCKED_APP_IMAGE_DIGEST=\"${APP_IMAGE_DIGEST}\"" >> "${LOCKED_IMAGES_DIGESTS_FILE}"
echo "export LOCKED_DB_IMAGE_DIGEST=\"${DB_IMAGE_DIGEST}\"" >> "${LOCKED_IMAGES_DIGESTS_FILE}"

