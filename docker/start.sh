#!/usr/bin/bash

set -euxo pipefail

chown -R cloudron:cloudron /app/data
mkdir -p /app/data/files

export FOCALBOARD_SERVERROOT=$CLOUDRON_APP_ORIGIN
export FOCALBOARD_DBTYPE="postgres"
export FOCALBOARD_DBCONFIG="postgres://${CLOUDRON_POSTGRESQL_USERNAME}:$CLOUDRON_POSTGRESQL_PASSWORD@$CLOUDRON_POSTGRESQL_HOST:$CLOUDRON_POSTGRESQL_PORT/$CLOUDRON_POSTGRESQL_DATABASE"
export FOCALBOARD_POSTGRES_DBCONFIG="dbname=${CLOUDRON_POSTGRESQL_DATABASE}"
export FOCALBOARD_WEBPATH="./pack"
export FOCALBOARD_FILESPATH="/app/data"
export FOCALBOARD_TELEMETRY="false"

/usr/local/bin/gosu cloudron:cloudron /opt/focalboard/bin/focalboard-server