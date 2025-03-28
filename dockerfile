# Imagen base de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN docker-php-ext-install pdo pdo_mysql

# Habilitar mod_rewrite para Laravel
RUN a2enmod rewrite

COPY apache-config.conf /etc/apache2/sites-available/000-default.conf

# Copiar el proyecto entero
COPY . /var/www/html/

# Definir el directorio de trabajo en `public/`
WORKDIR /var/www/html/public

# Cambiar permisos de almacenamiento y caché
RUN chmod -R 775 /var/www/html/storage /var/www/html/bootstrap/cache

# Exponer el puerto 80
EXPOSE 80

# Comando para iniciar Apache
CMD ["apache2-foreground"]
