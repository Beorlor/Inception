#!/bin/sh

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

    # Enable Redis caching for WordPress
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --raw --allow-root
    wp config set WP_CACHE_KEY_SALT "$DOMAIN_NAME" --allow-root
    wp config set WP_REDIS_CLIENT phpredis --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
    wp redis enable --allow-root
fi

exec "$@"
