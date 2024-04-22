FROM ubuntu:latest

WORKDIR /var/www/html

# Update package lists and install prerequisites
RUN apt update && apt install -y curl

ENV DEBIAN_FRONTEND=noninteractive

RUN apt install -y php tzdata

# Install PHP version and extensions
RUN apt install -y php8.3-cli php8.3-xml php8.3-curl php8.3-mbstring php8.3-tokenizer php8.3-fileinfo

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --version=1.10.26 --install-dir=/usr/local/bin --filename=composer

# Copy your Laravel application files into the container
COPY . .

# Install Composer dependencies
RUN composer install

# Generate Laravel application key
RUN php artisan key:generate

# Expose port (if needed)
EXPOSE 81

# CMD or ENTRYPOINT instructions here if needed
CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=81"]
