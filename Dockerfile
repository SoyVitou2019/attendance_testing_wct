FROM php:8.2.18-zts-bullseye

WORKDIR /var/www/html

RUN apt-get update && apt-get install -y curl

RUN curl -sS https://getcomposer.org/installer | php -- --version=2.4.3 --install-dir=/usr/local/bin --filename=composer

COPY . .
RUN composer install

CMD ["php", "artisan", "serve", "--host=0.0.0.0"]
