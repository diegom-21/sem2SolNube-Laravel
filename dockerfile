# Usa una imagen oficial de PHP con FPM y Composer
FROM php:8.1-fpm

# Instala dependencias del sistema y extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    unzip \
    git \
    curl \
    libonig-dev \
    libzip-dev \
    && docker-php-ext-configure gd \
    && docker-php-ext-install gd pdo pdo_pgsql pdo_mysql mbstring fileinfo bcmath zip

# Instala Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Configura el directorio de trabajo
WORKDIR /var/www

# Copia los archivos del proyecto
COPY . .

# Instala dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Genera la clave de la aplicación
RUN php artisan key:generate

# Configura permisos adecuados
RUN chmod -R 777 storage bootstrap/cache

# Expone el puerto 9000
EXPOSE 9000

# Comando de inicio para PHP-FPM
CMD ["php-fpm"]
