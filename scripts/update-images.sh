#!/usr/bin/env bash

mv .env .old-env
docker-compose pull
./scripts/lock-images-digests.sh
cmp --silent .env .old-env || make reload
rm .old-env
