# Base Image
FROM php:8.2.12-apache

# Change user to root
USER root

# Development Packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    zip \
    unzip \
    libicu-dev \
    libbz2-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    g++ \
    libzip-dev \
    libonig-dev \
    supervisor \
    iputils-ping \
    curl \
    rsync \
    sudo

# MySQL Extension
RUN docker-php-ext-install mysqli pdo_mysql

# Additional PHP extensions
RUN docker-php-ext-install \
    bz2 \
    intl \
    iconv \
    bcmath \
    opcache \
    mbstring \
    zip \
    #calendar \
    pdo_mysql

# Clear Cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

# Enable Apache Modules
RUN a2enmod rewrite headers

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set Up Docker-related Files
WORKDIR /home/docker
COPY docker .
RUN chmod +x entrypoint.sh

# Set Up Laravel Application
WORKDIR /home/www
COPY src .
RUN composer install --no-dev --optimize-autoloader

# Set Correct Permissions for Laravel
RUN chown -R www-data:www-data . \
    && chmod -R 755 storage bootstrap/cache

# Optimize Laravel
RUN php artisan config:cache \
    && php artisan route:cache \
    && php artisan view:cache \
    && php artisan event:cache \
    && php artisan optimize

# Expose Apache Port
EXPOSE 80

# Set entrypoint
ENTRYPOINT ["/home/docker/entrypoint.sh"]

# Start Apache
CMD ["apache2-foreground"]
