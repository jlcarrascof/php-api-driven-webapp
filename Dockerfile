FROM php:8.2-apache

# Install system dependencies required for PHP extensions
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-install pdo_mysql mbstring zip \
    && docker-php-ext-install curl \
    && rm -rf /var/lib/apt/lists/*

# Set the Apache document root to /var/www/html/public
ENV APACHE_DOCUMENT_ROOT=/var/www/html/public

# Update the Apache configuration to use the new document root
RUN sed -ri -e 's!/var/www/html!/var/www/html/public!g' /etc/apache2/sites-available/000-default.conf /etc/apache2/apache2.conf

# Enable Apache mod_rewrite for pretty URLs
RUN a2enmod rewrite

WORKDIR /var/www/html

# Copy application source
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
