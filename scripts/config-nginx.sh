#!/usr/bin/env bash

set -e

SCRIPTPATH="$(cd "$(dirname "$0")" ; pwd -P)"
BASEPATH="$(cd "${SCRIPTPATH}/.." && pwd)"

read -p "Enter the app domain: " DOMAIN

SOURCE_CONF_FILE="${BASEPATH}/conf/nginx.conf"
TARGET_CONF_FILE="/etc/nginx/sites-enabled/${DOMAIN}.conf"


if [[ ! $EUID -eq 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi


if [ ! -f ./certbot-auto ]; then
  wget https://dl.eff.org/certbot-auto
  chmod +x certbot-auto
fi

./certbot-auto certonly \
  --webroot \
  -d ${DOMAIN} \
  --agree-tos


if [ ! -f ${TARGET_CONF_FILE} ]; then
  echo "Config file not found. crating a new one..."

  cp ${SOURCE_CONF_FILE} ${TARGET_CONF_FILE}
  perl -pi -e "s#\[DOMAIN\]#${DOMAIN}#g" ${TARGET_CONF_FILE}

  echo "Restarting Nginx..."
  service nginx restart
fi

