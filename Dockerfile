FROM php:8.2.18-zts-bullseye

# Set working directory
WORKDIR /var/www/html

# Update package lists
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install zip \
    && rm -rf /var/lib/apt/lists/*

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version=2.1.8

# Copy application files
COPY . .

# Install project dependencies
RUN composer install --no-dev --optimize-autoloader

# Expose port 8000 to the outside world
EXPOSE 8100

# Command to run the application
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=8100"]
