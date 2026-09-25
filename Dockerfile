FROM php:8.5.10-apache

RUN apt update

RUN docker-php-ext-install mysqli

WORKDIR /var/www/html/

COPY index.php .