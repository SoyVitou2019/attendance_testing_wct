FROM php:7.2-fpm

# Copy composer.lock and composer.json
COPY composer.json /var/www/

WORKDIR /var/www

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# Install PHP extensions
RUN apt install -y php8.1-cli php8.1-xml php8.1-curl php8.1-mbstring php8.1-tokenizer php8.1-fileinfo

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www


# Copy existing application directory contents
COPY . /var/www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www

# Change current user to www
USER www

# composer install
RUN composer install

# Generate Laravel application key
RUN php artisan key:generate

# Expose port (if needed)
EXPOSE 81

# CMD or ENTRYPOINT instructions here if needed
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
