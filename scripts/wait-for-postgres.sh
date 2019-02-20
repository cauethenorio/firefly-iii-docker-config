#!/bin/sh
# wait-for-postgres.sh

set -e

until PGPASSWORD=$POSTGRES_PASSWORD psql -h "127.0.0.1" -U "${POSTGRES_USER}" -c '\q' &> /dev/null; do
  >&2 echo "Waiting for postgres..."
  sleep 2
done

>&2 echo "Postgres is up"
