# PHP Service
FROM php:8.2 as php

# Install dependencies
RUN apt-get update -y \
    && apt-get install -y unzip libpq-dev libcurl4-gnutls-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql bcmath \
    && pecl install -o -f redis \
    && docker-php-ext-enable redis

# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

# Copy Composer binary from Composer image
COPY --from=composer:1.29.2 /usr/bin/composer /usr/bin/composer

# Set environment variables
ENV PORT=8100

# Set entrypoint script
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]


# Set working directory
WORKDIR /var/www

# Copy application files
COPY . .

