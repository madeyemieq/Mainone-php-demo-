FROM php:8.2-fpm

# Set working directory
WORKDIR /var/www

# Install system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip \
    curl \
    git \
    vim \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    nano \
    libssl-dev \
    libmagickwand-dev --no-install-recommends

# Install PHP extensions
RUN docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd zip intl

# Install Composer globally
COPY --from=composer:2.7 /usr/bin/composer /usr/bin/composer

# Copy Laravel project files
COPY . .

# Set permissions
RUN chown -R www-data:www-data /var/www \
    && chmod -R 755 /var/www/storage

EXPOSE 9000
CMD ["php-fpm"]
