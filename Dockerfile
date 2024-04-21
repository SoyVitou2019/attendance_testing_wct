FROM php:8.2.18-zts-bullseye

# Set environment variables for Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/composer
RUN php artisan key:generate
# Install system dependencies
RUN apt-get update \
    && apt-get install -y \
        git \
        zip \
        unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www/html

# Copy application files
COPY . .

# Run Composer install
RUN composer install --no-plugins --no-scripts

# Expose port if needed
EXPOSE 81

# Define the command to run the application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
