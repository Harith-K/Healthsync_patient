#!/bin/bash

# Log all environment variables for debugging
echo "Logging environment variables..."
env

# Debugging specific secrets
echo "DOCKER_USERNAME: $DOCKER_USERNAME, DOCKER_PASSWORD: $DOCKER_PASSWORD"
echo "MYSQL_DATABASE: $MYSQL_DATABASE, MYSQL_USER: $MYSQL_USER, MYSQL_PASSWORD: $MYSQL_PASSWORD, MYSQL_HOST: $MYSQL_HOST"

# Check if all required secrets are present
if [ -z "$MYSQL_HOST" ]; then
  echo "Error: MYSQL_HOST is not set"
  exit 1
fi

if [ -z "$MYSQL_DATABASE" ]; then
  echo "Error: MYSQL_DATABASE is not set"
  exit 1
fi

if [ -z "$MYSQL_USER" ]; then
  echo "Error: MYSQL_USER is not set"
  exit 1
fi

if [ -z "$MYSQL_PASSWORD" ]; then
  echo "Error: MYSQL_PASSWORD is not set"
  exit 1
fi

# Wait for the database to be ready
echo "Waiting for database to be ready..."
while ! nc -z "$MYSQL_HOST" 3306; do
  sleep 1
done
echo "Database is ready!"

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the server
echo "Starting the Django server..."
exec "$@"
