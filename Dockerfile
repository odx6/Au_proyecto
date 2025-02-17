# ================================
# Base: PHP con Node.js y Nginx
# ================================
FROM php:8.2-fpm

# Instalamos dependencias del sistema
RUN apt-get update && apt-get install -y \
    curl \
    zip \
    unzip \
    git \
    nginx \
    supervisor \
    libpq-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# ================================
# Instalamos Composer
# ================================
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# ================================
# Instalamos Node.js y npm
# ================================
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

# ================================
# Configuración de Laravel
# ================================
WORKDIR /var/www/html
COPY . .

# Instalamos dependencias de PHP y Node.js
RUN composer install --no-dev --no-interaction --optimize-autoloader && \
    npm install && \
    npm run build && \
    php artisan optimize && \
    php artisan storage:link

# ================================
# Configuración de Nginx
# ================================
COPY ./nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html/storage && chown -R www-data:www-data /var/www/html

# ================================
# Configuración de Supervisor
# ================================
COPY ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# ================================
# Permisos
# ================================
RUN chown -R www-data:www-data /var/www/html

# ================================
# Exponemos puertos y ejecutamos servicios
# ================================
EXPOSE 80
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
