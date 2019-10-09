#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE DATABASE logging;
    CREATE USER logging WITH PASSWORD 'logging';
    GRANT ALL PRIVILEGES ON DATABASE logging TO logging;
    \connect logging;
    CREATE EXTENSION IF NOT EXISTS timescaledb CASCADE;
    CREATE TABLE log_records (
      time   TIMESTAMP NOT NULL,
      tag    CHAR(128) NOT NULL,
      record JSONB     NOT NULL
    );
    SELECT create_hypertable('log_records', 'time');
    GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public to logging;
    GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public to logging;
    GRANT ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public to logging;
EOSQL
