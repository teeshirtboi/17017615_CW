#!/bin/sh
set -eu

APP_PASSWORD="$(cat /run/secrets/db_password)"

psql -v ON_ERROR_STOP=1 \
    --username "$POSTGRES_USER" \
    --dbname "$POSTGRES_DB" \
    -v app_password="$APP_PASSWORD" <<'EOSQL'

CREATE ROLE cyberdelia
    LOGIN
    NOSUPERUSER
    NOCREATEDB
    NOCREATEROLE
    NOINHERIT
    NOREPLICATION
    NOBYPASSRLS
    PASSWORD :'app_password';

EOSQL
