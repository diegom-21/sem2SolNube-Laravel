# Usar una imagen base oficial de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

# Configurar el directorio de trabajo
WORKDIR /var/www/html

# Copiar archivos del proyecto a la imagen
COPY . .

# Ajustar permisos para almacenamiento y caché
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer el puerto 80
EXPOSE 80

# Comando de inicio del contenedor
CMD ["apache2-foreground"]
