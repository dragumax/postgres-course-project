#!/bin/bash
set -euo pipefail

BACKUP_DIR="/backups"
DB_USER=$(cat /run/secrets/db_user)
DB_NAME=$(cat /run/secrets/db_name)
DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/${DB_NAME}_$DATE.sql.gz"
RETENTION_DAYS=7

pg_dump -U "$DB_USER" -d "$DB_NAME" | gzip > "$BACKUP_FILE"
find "$BACKUP_DIR" -name "${DB_NAME}_*.sql.gz" -type f -mtime +$RETENTION_DAYS -delete

echo "Backup created: $BACKUP_FILE"
