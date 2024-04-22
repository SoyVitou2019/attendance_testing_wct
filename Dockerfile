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

# Create a new user
RUN useradd -ms /bin/bash laravel_user

# Set up your application directory and permissions
WORKDIR /home/laravel_project
RUN chown -R laravel_user:laravel_user /home/laravel_project

# Switch to the new user
USER laravel_user

# Copy your Laravel application files into the container
COPY . .

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/home/laravel_project/bin --filename=composer

# Install Composer dependencies
RUN php /home/laravel_project/bin/composer install --no-plugins --no-scripts --no-interaction

# Generate Laravel application key
RUN php artisan key:generate

# Expose port (if needed)
EXPOSE 81

# CMD or ENTRYPOINT instructions here if needed
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
