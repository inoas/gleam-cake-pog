#!/usr/bin/env sh

set -eu

psql <<SQL
SELECT 'CREATE DATABASE gleam_cake_pgo_test'
WHERE NOT EXISTS (
  SELECT FROM pg_database WHERE datname = 'gleam_cake_pgo_test'
)\\gexec
SQL
