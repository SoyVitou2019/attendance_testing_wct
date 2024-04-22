FROM ubuntu:latest

RUN apt update && \
    apt install -y curl software-properties-common && \
    add-apt-repository ppa:ondrej/php -y && \
    apt update && \
    apt install -y php-fpm php-cli unzip php-ctype php-curl php-dom php-fileinfo php-mbstring php-pdo php-tokenizer php-xml

# Install Composer
RUN curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php && \
    HASH=`curl -sS https://composer.github.io/installer.sig` && \
    php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

# Copy Laravel project files
COPY . /laravel_project

# Install dependencies
RUN cd /laravel_project && \
    composer install --no-plugins --no-scripts

# Generate Laravel application key
RUN cd /laravel_project && \
    php artisan key:generate

EXPOSE 81

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
