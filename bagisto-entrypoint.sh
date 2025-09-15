#!/bin/bash
set -e

# Wait for MySQL to be ready
echo "Waiting for MySQL..."
until mysql -h "$DB_HOST" -u "$DB_USERNAME" -p"$DB_PASSWORD" "$DB_DATABASE" &> /dev/null
do
  sleep 3
done
echo "MySQL is up - running migrations"

# Run migrations and seed database
#php artisan migrate --force
#php artisan db:seed --force

# Start Apache in foreground
#apache2-foreground
