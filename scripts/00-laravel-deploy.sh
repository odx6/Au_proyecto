echo "Running composer"
 node -v && npm -v
echo "Installing node"
 npm install 
echo "Installing node"
npm audit fix --force
npm  run build
echo "COPILAR PROYECTO "

composer global require hirak/prestissimo
composer install --no-dev --working-dir=/var/www/html
echo "Caching config..."
php artisan config:cache
echo "Caching routes..."
php artisan route:cache
echo "Running migrations..."
echo "Running view..."
php artisan view:cache
echo "Running optimeze ..."
php artisan optimize
echo "Running KEYGENERATE..."
php artisan key:generate
echo "Running STORAGE..."
php artisan storage:link
echo "Generacion de permisos"
chmod -R 775 storage
chmod -R 775 bootstrap/cache
php artisan migrate --force
