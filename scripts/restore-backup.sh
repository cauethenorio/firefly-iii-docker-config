#!/usr/bin/env bash

set -e

if [ -z "${BACKUP_FILE}" ]; then
  LAST_BACKUP_FILE=$(ls -1 backups|tail -n1)
  echo "No backup file arg specified. (i.e. 'make restore-backup file=backup.tar.gz')"
  read -p "The last created backup file should be used '${LAST_BACKUP_FILE}'? [y/n] " CONFIRM

  if [ "${CONFIRM,,}" != "y" ]; then
      echo >&2 "Aborted."
  fi

  BACKUP_FILE="${LAST_BACKUP_FILE}"
fi

if [ ! -f "./backups/${BACKUP_FILE}" ]; then
  echo "Backup file '${BACKUP_FILE}' not found. Cancelling..."
  exit
fi

make reset

tar xzf "./backups/${BACKUP_FILE}"
mv ./generated_data/.{app-,}env .
make up
