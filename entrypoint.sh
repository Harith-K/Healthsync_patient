#!/bin/bash

# Hardcoded Database Credentials
MYSQL_HOST="healthsync-db.c1c4ousc21sc.us-east-1.rds.amazonaws.com"
MYSQL_PORT="3306"
MYSQL_USER="admin"
MYSQL_PASSWORD="Harith1673"

# Debug environment variables

# Wait for the database to be ready
echo "Waiting for database to be ready..."
for i in {1..30}; do
  if nc -z "$MYSQL_HOST" "$MYSQL_PORT"; then
    echo "Database is ready!"
    break
  fi
  echo "Waiting..."
  sleep 2
done

if ! nc -z "$MYSQL_HOST" "$MYSQL_PORT"; then
  echo "Error: Unable to connect to database at $MYSQL_HOST:$MYSQL_PORT"
  exit 1
fi

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the server
echo "Starting the Django server..."
exec "$@"
