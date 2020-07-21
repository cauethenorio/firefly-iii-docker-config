#!/usr/bin/env bash

TARGET_FILE=".app-env"

if [ ! -f ${TARGET_FILE} ]; then
  cp ./conf/${TARGET_FILE}.template ${TARGET_FILE}

  read -p "Enter your email address: " SITE_OWNER
  export SITE_OWNER
  read -p "Enter the app domain: " APP_DOMAIN
  export APP_DOMAIN
  read -p "Default language (en_US will be used if empty): " LANGUAGE
  export LANGUAGE=${LANGUAGE:-en_US}
  read -p "Your timezone (example: America/Sao_Paulo): " TIMEZONE
  export TIMEZONE

  export APP_KEY="$(base64 /dev/urandom | tr -d '+/\r\n' | head -c 32)"
  perl -pi -e 's/\[APP_KEY\]/$ENV{APP_KEY}/g' ${TARGET_FILE}
  perl -pi -e 's/\[SITE_OWNER\]/$ENV{SITE_OWNER}/g' ${TARGET_FILE}
  perl -pi -e 's/\[APP_DOMAIN\]/$ENV{APP_DOMAIN}/g' ${TARGET_FILE}
  perl -pi -e 's/\[LANGUAGE\]/$ENV{LANGUAGE}/g' ${TARGET_FILE}
  perl -pi -e 's/\[TIMEZONE\]/$ENV{TIMEZONE}/g' ${TARGET_FILE}
fi
