#!/bin/sh

# Wait for MariaDB to be ready
until mysqladmin ping -h"$MARIA_HOSTNAME" --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

# Check if wp-config.php already exists
if [ -f ./wp-config.php ]; then
    echo "WordPress is already set up."
else
    # Download and configure WordPress
    wget http://wordpress.org/latest.tar.gz
    tar xfz latest.tar.gz
    mv wordpress/* .
    rm -rf latest.tar.gz wordpress

    # Configure WordPress with environment variables
    wp config create --allow-root \
        --dbname="$MARIA_DATABASE" \
        --dbuser="$MARIA_USER" \
        --dbpass="$MARIA_PASSWORD" \
        --dbhost="mariadb:3306" \
        --path='/var/www/html'

    # Install WordPress with admin user configuration
    wp core install --allow-root \
        --url="$DOMAIN_NAME" \
        --title="$WP_TITLE" \
        --admin_user="$WORDPRESS_ADMIN" \  # Ensure this does not contain "admin"
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email

    # Create the second WordPress user with editor permissions
    wp user create "$SECOND_WP_USER" "$SECOND_WP_EMAIL" --role=editor --user_pass="$SECOND_WP_PASSWORD" --allow-root

    # Enable Redis caching for WordPress
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT "$DOMAIN_NAME" --allow-root
    wp config set WP_REDIS_CLIENT phpredis --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable --allow-root
fi

# Start php-fpm in the foreground
exec php-fpm7.4 -F
