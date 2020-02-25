FROM php:7.2-fpm

RUN apt-get update && apt-get install -y libmcrypt-dev vim && apt clean
RUN pecl install mcrypt-1.0.1 && docker-php-ext-enable mcrypt
RUN apt-get install -y libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev libpng-dev && apt clean
RUN docker-php-ext-install -j$(nproc) iconv pdo_mysql 
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install -j$(nproc) gd 

WORKDIR /var/www

