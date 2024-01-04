#!/usr/bin/bash
chown -R cloudron:cloudron /app/data
mkdir -p /app/data/files

export FOCALBOARD_SERVERROOT=$CLOUDRON_APP_ORIGIN
export FOCALBOARD_DBTYPE="postgres"
export FOCALBOARD_DBCONFIG="postgres://${CLOUDRON_POSTGRES_USERNAME}:$CLOUDRON_POSTGRES_PASSWORD@$CLOUDRON_POSTGRES_HOST:$CLOUDRON_POSTGRES_PORT/$CLOUDRON_POSTGRES_DATABASE"
export FOCALBOARD_POSTGRES_DBCONFIG="dbname=${CLOUDRON_POSTGRES_DATABASE}"
export FOCALBOARD_WEBPATH="./pack"
export FOCALBOARD_FILESPATH="/app/data"
export FOCALBOARD_TELEMETRY="false"

/usr/local/bin/gosu cloudron:cloudron /opt/focalboard/bin/focalboard-server