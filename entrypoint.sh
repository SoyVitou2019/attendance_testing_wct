#!/bin/bash

# Change directory to application directory
cd /var/www

# Check if vendor/autoload.php exists, if not, run composer install
if [ ! -f "vendor/autoload.php" ]; then
    composer install --no-progress --no-interaction
fi

# Check if .env file exists, if not, copy from .env.example
if [ ! -f ".env" ]; then
    echo "Creating .env file"
    cp .env.example .env
fi

# Set container role
role=${CONTAINER_ROLE:-app}

# If role is "app", execute necessary commands
if [ "$role" = "app" ]; then
    php artisan migrate --force
    php artisan key:generate
    php artisan cache:clear
    php artisan config:clear
    php artisan route:clear
    php artisan serve --host=0.0.0.0 --port=80
else
    # Else, execute whatever other command needed
    exec "$@"
fi
