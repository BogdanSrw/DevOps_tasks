#!/bin/bash

source .env

USAGE=$(df -h "$DISK" | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
    echo -e "Subject: Disk Alert\n\nDisk usage on $DISK is at ${USAGE}%" | \
    msmtp --host=$SMTP_SERVER --port=$SMTP_PORT --auth=on --user=$SMTP_LOGIN --passwordeval="echo $SMTP_PASS" --tls=on --from=$EMAIL_FROM $EMAIL_TO
fi

