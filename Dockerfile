FROM php:8.2-apache

# Install system dependencies required for PHP extensions
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip \
    && docker-php-ext-install curl \
    && rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite for pretty URLs
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application source
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
