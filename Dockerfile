FROM php:8.3.6-zts-bullseye

WORKDIR /laravel_project
ENV COMPOSER_ALLOW_SUPERUSER=1
# Install dependencies
RUN apt -y update 
RUN apt -y upgrade
RUN apt install -y curl git

# # install php
# ENV DEBIAN_FRONTEND=noninteractive

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copy existing application directory contents
COPY . ./laravel_project

RUN rm ./laravel_project/composer.lock

# composer install
RUN composer install

# Generate Laravel application key
RUN php artisan key:generate

# Expose port (if needed)
EXPOSE 81

# CMD or ENTRYPOINT instructions here if needed
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]