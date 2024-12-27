#!/bin/bash

echo "DB_HOST: $DB_HOST, DB_PORT: $DB_PORT, DB_USER: $DB_USER, DB_PASSWORD: $DB_PASSWORD"
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

