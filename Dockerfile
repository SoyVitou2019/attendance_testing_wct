FROM php:8.3.6-zts-bullseye

WORKDIR /laravel_project

ENV COMPOSER_ALLOW_SUPERUSER=1

# Install dependencies
RUN apt -y update && apt -y upgrade && apt install -y curl git unzip zip

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY . .

# Install PHP extensions, if needed
RUN docker-php-ext-install pdo pdo_mysql

# Install Composer dependencies
COPY composer.json /laravel_project/
RUN composer install --no-scripts

# Copy artisan file
COPY artisan /laravel_project/artisan
COPY .env /laravel_project/.env
# Generate key
RUN php artisan key:generate
RUN php artisan cache:clear
RUN php artisan view:clear
RUN php artisan route:clear


# Expose port
EXPOSE 81

# Start Laravel server
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
