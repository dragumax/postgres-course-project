#!/bin/bash
set -euo pipefail

DB_PASS=$(cat ../../secrets/db_password.txt)
DB_USER=$(cat ../../secrets/db_user.txt)
DB_NAME=$(cat ../../secrets/db_name.txt)

export PGPASSWORD="$DB_PASS"
psql -h localhost -p 5432 -U "$DB_USER" -d "$DB_NAME" -c "SELECT 1;" > /dev/null

if [ $? -eq 0 ]; then
    echo "✅ PostgreSQL test passed."
    exit 0
else
    echo "❌ PostgreSQL test failed."
    exit 1
fi
