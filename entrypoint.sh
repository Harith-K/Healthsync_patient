#!/bin/bash

# Debugging - Print environment variables for verification
echo "Loaded Environment Variables:"
env

# Wait for the database to be ready
echo "Waiting for database to be ready..."
while ! nc -z "$MYSQL_HOST" 3306; do
  sleep 1
done
echo "Database is ready!"

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

# Start the Django server
echo "Starting the Django server..."
exec "$@"
