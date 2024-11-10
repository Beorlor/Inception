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

    # Configure WordPress using environment variables
    sed -i "s/username_here/$MARIA_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MARIA_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MARIA_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_here/$MARIA_DATABASE/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

    # Install WordPress
    wp core install \
        --url="$DOMAIN_NAME" \
        --title="Your Site Title" \
        --admin_user="$WORDPRESS_ADMIN" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

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
