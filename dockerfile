# Usar una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias para Laravel
RUN docker-php-ext-install pdo pdo_mysql

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Copiar todos los archivos del proyecto al contenedor
COPY . .

# Ajustar permisos para almacenamiento y caché
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer el puerto 80
EXPOSE 80

# Comando de inicio del contenedor
CMD ["apache2-foreground"]
