#!/bin/bash

DOMAIN=$1
HOST=$2
TEMPLATE_FILE=$3
SITE_FILE=$4

sed -e "s/DOMAIN/${DOMAIN}/;s/HOST/${HOST}/" $TEMPLATE_FILE > ./nginx/sites/$SITE_FILE
