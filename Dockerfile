FROM php:8.2.18-zts-bullseye

# Set environment variables for Composer
ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_HOME=/composer

# Install system dependencies
RUN apt-get update \
    && apt-get install -y \
        git \
        zip \
        unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set the working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Run Composer install
RUN composer install --no-progress --no-interaction

# Expose port if needed (assuming your application needs a specific port)
EXPOSE 81

# Set entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
