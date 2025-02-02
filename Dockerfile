# Usar la imagen oficial de PHP
FROM php:8.2-fpm

# Instalar dependencias de Laravel
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    && docker-php-ext-install pdo pdo_mysql mbstring exif pcntl bcmath gd

# Instalar Node.js y npm
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Establecer el directorio de trabajo
WORKDIR /var/www

# Copiar el código de la aplicación Laravel
COPY . .

# Instalar dependencias de Laravel
RUN composer install --no-dev --optimize-autoloader

# Instalar dependencias de Node.js (Vue.js)
RUN npm install

# Exponer puertos (Laravel en 9000, MySQL en 3306)
EXPOSE 9000


# Comando por defecto
CMD ["php-fpm"]