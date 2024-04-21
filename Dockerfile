FROM php:8.2.18-zts-bullseye

WORKDIR /var/www/html

RUN apk update 
RUN curl -sS https://getcomposer.org/installer \
 | php -- --version=1.10.26 \
 --install-dir=/usr/local/bin --filename=composer

 COPY . .

 RUN composer install

 CMD ["php","artisan","serve","--host=0.0.0.0"]