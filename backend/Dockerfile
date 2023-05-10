# Base image
FROM php:8.1-fpm

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/html

# Copy composer.json and composer.lock
COPY ./composer.json ./composer.lock /var/www/html/

# Install project dependencies
RUN composer install --no-scripts --no-autoloader

# Copy the rest of the application
COPY . /var/www/html/

# Generate autoload files and optimize Laravel
RUN composer dump-autoload --optimize

# Expose port 8000 and start PHP-FPM server
EXPOSE 8000
CMD ["php-fpm"]

# Build command
# docker build -t myapp_backend .

# Run command
# docker run --rm -it -v $(pwd):/var/www/html -p 9000:9000 --name myapp_backend myapp_backend
