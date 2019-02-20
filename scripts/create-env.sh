#!/bin/sh

TARGET_FILE=".env"

if [ ! -f ${TARGET_FILE} ]; then
  cp ./conf/${TARGET_FILE}.template ${TARGET_FILE}

  read -p "Enter your email address: " SITE_OWNER
  SITE_OWNER=${SITE_OWNER/@/\\@} # escape the @ or perl will mess with it
  read -p "Enter your mailgun domain: " MAILGUN_DOMAIN
  read -p "Enter your mailgun key: " MAILGUN_SECRET
  read -p "Enter your mapbox API: " MAPBOX_API_KEY

  perl -pi -e "s/\[APP_KEY\]/$(base64 /dev/urandom | head -c 128|md5)/g" ${TARGET_FILE}
  perl -pi -e "s/\[SITE_OWNER\]/${SITE_OWNER}/g" ${TARGET_FILE}
  perl -pi -e "s/\[MAILGUN_DOMAIN\]/${MAILGUN_DOMAIN}/g" ${TARGET_FILE}
  perl -pi -e "s/\[MAILGUN_SECRET\]/${MAILGUN_SECRET}/g" ${TARGET_FILE}
  perl -pi -e "s/\[MAPBOX_API_KEY\]/${MAPBOX_API_KEY}/g" ${TARGET_FILE}
fi
