FROM ubuntu:latest

# Update package lists and install prerequisites
RUN apt update && \
    apt install -y curl software-properties-common

# Add repository for PHP
RUN add-apt-repository ppa:ondrej/php -y && \
    apt update

# Install PHP version and extensions
RUN apt install -y php8.3-fpm php8.3-cli php8.3-xml php8.3-curl php8.3-mbstring php8.3-tokenizer php8.3-fileinfo

# Clean up
RUN apt autoremove -y && \
    apt clean

# Set up your application
WORKDIR /var/www/html

# Copy your Laravel application files into the container
COPY . .

# Install Composer and dependencies
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Switch to a non-root user
USER www-data

# Install Composer dependencies
RUN composer install --no-plugins --no-scripts

# Generate Laravel application key
RUN php artisan key:generate

# Expose port (if needed)
EXPOSE 81

# CMD or ENTRYPOINT instructions here if needed
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
