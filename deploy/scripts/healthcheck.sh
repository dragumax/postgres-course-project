#!/bin/bash
set -euo pipefail

DB_USER=$(cat /run/secrets/db_user)
DB_NAME=$(cat /run/secrets/db_name)

pg_isready -U "$DB_USER" -d "$DB_NAME" || exit 1
psql -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1;" > /dev/null || exit 1
echo "Healthy"
exit 0
