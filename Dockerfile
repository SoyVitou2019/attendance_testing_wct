FROM ubuntu:latest

RUN apt update

# install curl for download composer
RUN apt install curl -y
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php -y
RUN apt-get update

# install php version fpm
RUN apt install php-fpm -y

# install php extensions
RUN apt install php-cli unzip
RUN apt install php-ctype php-curl php-dom php-fileinfo
RUN apt install -y php-mbstring
RUN apt install php-pdo php-tokenizer php-xml

# install composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
RUN HASH=`curl -sS https://composer.github.io/installer.sig`
RUN php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

COPY . ./laravel_project

RUN composer install --no-plugins --no-scripts

RUN php artisan key:generate

EXPOSE 81

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
