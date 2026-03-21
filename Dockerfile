FROM php:8.2-apache

# Install required PHP extensions
RUN docker-php-ext-install pdo_mysql curl mbstring

# Enable Apache mod_rewrite for pretty URLs
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Copy application source
COPY src/ /var/www/html/

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html
