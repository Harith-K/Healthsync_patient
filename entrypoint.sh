#!/bin/bash

# Debug environment variables
echo "MYSQL_HOST: $MYSQL_HOST, MYSQL_PORT: 3306, MYSQL_USER: $MYSQL_USER, MYSQL_PASSWORD: $MYSQL_PASSWORD"
echo "DOCKER_USERNAME: $DOCKER_USERNAME, DOCKER_PASSWORD: $DOCKER_PASSWORD"

# Wait for the database to be ready
echo "Waiting for database to be ready..."
for i in {1..30}; do
  if nc -z "$MYSQL_HOST" 3306; then
    echo "Database is ready!"
    break
  fi
  echo "Waiting..."
  sleep 2
done

if ! nc -z "$MYSQL_HOST" 3306; then
  echo "Error: Unable to connect to database at $MYSQL_HOST:3306"
  exit 1
fi

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the server
echo "Starting the Django server..."
exec "$@"
