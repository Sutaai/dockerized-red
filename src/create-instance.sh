#!/usr/bin/env sh
set -eufx

if [ "$STORAGE" = "postgres" ]; then
  if [ -z "${PSQL_HOST:-}" ]; then
    echo "Please set the PSQL_HOST environment variable to the database's hostname"
    exit 1
  fi

  STORAGE_TYPE="Postgres"
  PSQL_USER=${PSQL_USER:-postgres}

  # Build a JSON object with all details required for storage
  STORAGE_DETAILS=$(
    jq -n -c \
      --arg psqlhost "${PSQL_HOST}" \
      --arg psqlport "${PSQL_PORT:-5432}" \
      --arg psqluser "${PSQL_USER}" \
      --arg psqlpass "${PSQL_PASSWORD:-${PSQL_USER}}" \
      --arg psqldb "${PSQL_DATABASE:-${PSQL_USER}}" \
      '{host: $psqlhost, port: $psqlport, user: $psqluser, password: $psqlpass, database: $psqldb}'
  )
elif [ "$STORAGE" = "json" ]; then
  STORAGE_TYPE="JSON"
  # *pat pat*
  STORAGE_DETAILS={}
else
  echo "Unknown storage type specified: $STORAGE"
  exit 1
fi

# Final JSON config
# Reference: https://github.com/Cog-Creators/Red-DiscordBot/blob/V3/develop/redbot/core/data_manager.py#L33
jq -n -c \
  --arg instance "$INSTANCE_NAME" \
  --arg storagetype $STORAGE_TYPE \
  --argjson storage "$STORAGE_DETAILS" \
  '{
        ($instance): 
        {DATA_PATH: "/data", COG_PATH_APPEND: "cogs", CORE_PATH_APPEND: "core", STORAGE_TYPE: $storagetype, STORAGE_DETAILS: $storage}
    }' >/data/config.json

echo "Created instance $INSTANCE_NAME"
