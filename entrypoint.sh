#!/bin/bash

# Wait for the database to be ready
echo "Waiting for database to be ready..."
while ! nc -z "$MYSQL_HOST" "$MYSQL_PORT"; do
  sleep 1
done
echo "Database is ready!"

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the server
echo "Starting the Django server..."
exec "$@"
