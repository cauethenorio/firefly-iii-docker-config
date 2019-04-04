#!/usr/bin/env bash

read -p "This is will ERASE ALL YOUR DATA. Are you sure? [y/n]: " CONFIRM

if [ "${CONFIRM,,}" != "y" ]; then
    echo >&2 "Aborted."
fi

touch ".env"
make down

rm -Rf .env generated_data
echo "All clear."
