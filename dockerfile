# Usa la imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instala extensiones necesarias para Laravel
RUN apt-get update && apt-get install -y \
    libpq-dev zip unzip git curl \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql

# Habilita mod_rewrite para Laravel
RUN a2enmod rewrite

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establece el directorio de trabajo
WORKDIR /var/www/html

# Copia los archivos del proyecto
COPY . .

# Asigna los permisos correctos para Laravel
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Instala las dependencias de Composer optimizando para producción
RUN composer install --no-dev --no-interaction --prefer-dist --optimize-autoloader

# Genera la clave de la aplicación
RUN php artisan key:generate

# Limpia cachés y optimiza la aplicación
RUN php artisan config:cache && php artisan route:cache && php artisan view:cache

# Expone el puerto 80
EXPOSE 80

# Comando de inicio
CMD ["apache2-foreground"]
