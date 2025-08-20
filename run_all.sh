#!/usr/bin/env bash
# Creates a database, loads schema.sql and runs every file in queries/.
# Needs a running PostgreSQL and the psql client.   Usage: ./run_all.sh [database_name]
set -euo pipefail
DB="${1:-practice}"
createdb "$DB" 2>/dev/null || true
psql -v ON_ERROR_STOP=1 -d "$DB" -q -f schema.sql
for f in queries/*.sql; do
  echo "== $f"
  psql -v ON_ERROR_STOP=1 -d "$DB" -f "$f"
done
