# Usa la imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpq-dev \
    zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia los archivos del proyecto a /var/www/html
COPY . /var/www/html

# Configura permisos
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Expone el puerto 80
EXPOSE 80

# Comando de inicio
CMD ["apache2-foreground"]
