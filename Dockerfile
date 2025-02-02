# Imagen base de PHP con Apache
FROM php:8.1-apache

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    zip \
    git \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd \
    && docker-php-ext-install pdo pdo_mysql

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer



# Establecer el directorio de trabajo en /var/www/html
WORKDIR /var/www/html

# Copiar el código de Laravel al contenedor
COPY . .

# Instalar las dependencias de Laravel con Composer
RUN composer install --no-dev --optimize-autoloader

# Copiar y instalar dependencias de Node.js y Vue.js
WORKDIR /var/www/html/frontend
RUN npm install
RUN npm run build

# Exponer el puerto 80
EXPOSE 80

# Iniciar Apache en primer plano
CMD ["apache2-foreground"]