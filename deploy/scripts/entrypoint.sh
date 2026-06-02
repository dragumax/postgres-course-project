#!/bin/bash
set -euo pipefail

until pg_isready -U "$(cat /run/secrets/db_user)" -d "$(cat /run/secrets/db_name)"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

psql -U "$(cat /run/secrets/db_user)" -d "$(cat /run/secrets/db_name)" <<-EOSQL
    CREATE TABLE IF NOT EXISTS users (
        id SERIAL PRIMARY KEY,
        username VARCHAR(50) UNIQUE NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );
    INSERT INTO users (username) VALUES ('test_user') ON CONFLICT DO NOTHING;
EOSQL

echo "Init done."
