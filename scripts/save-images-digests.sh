#!/usr/bin/env bash

APP_IMAGE="jc5x/firefly-iii:latest"
DB_IMAGE="postgres:10"

IMAGES_DIGESTS_FILE="generated_data/images_digests.txt"

APP_IMAGE_DIGEST=$(docker image inspect ${APP_IMAGE} -f '{{index .RepoDigests 0}}')
DB_IMAGE_DIGEST=$(docker image inspect ${DB_IMAGE} -f '{{index .RepoDigests 0}}')

echo -n "" > "${IMAGES_DIGESTS_FILE}"

echo "${APP_IMAGE_DIGEST}" >> "${IMAGES_DIGESTS_FILE}"
echo "${DB_IMAGE_DIGEST}" >> "${IMAGES_DIGESTS_FILE}"
