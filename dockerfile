# Usa una imagen oficial de PHP con extensiones necesarias
FROM php:8.1-fpm

# Instala dependencias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd pdo pdo_mysql mbstring

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Copia los archivos del proyecto
WORKDIR /var/www
COPY . /var/www

# Instala las dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Configura permisos
RUN chmod -R 777 storage bootstrap/cache

# Expone el puerto 9000
EXPOSE 9000

CMD ["php", "artisan", "serve", "--host=0.0.0.0", "--port=9000"]
