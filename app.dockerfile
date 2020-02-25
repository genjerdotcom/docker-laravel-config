FROM php:7.2-fpm
# Copy composer.lock and composer.json
COPY ./composer.lock ./composer.json /var/www/
# Set working directory
WORKDIR /var/www
FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev vim && apt clean
RUN pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev vim && apt clean 
RUN docker-php-ext-install -j$(nproc) iconv pdo_mysql 
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd 

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
# Add user for laravel application
RUN groupadd -g 1000 www
RUN useradd -u 1000 -ms /bin/bash -g www www

# Copy existing application directory permissions
COPY --chown=www:www . /var/www
# Change current user to www
USER www

WORKDIR /var/www


