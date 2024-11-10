#!/bin/bash

# Start MariaDB in the background
mysqld_safe &

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB is ready."

# Create the database if it doesn't exist
mysql -u root -p"${MARIA_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MARIA_DATABASE}\`;"

# Create the user and grant privileges
mysql -u root -p"${MARIA_ROOT_PASSWORD}" -e "GRANT ALL ON ${MARIA_DATABASE}.* TO '${MARIA_USER}'@'%' IDENTIFIED BY '${MARIA_PASSWORD}'; FLUSH PRIVILEGES;"

# Change the root password
mysql -u root -p"${MARIA_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIA_ROOT_PASSWORD}';"

# Flush privileges
mysql -u root -p"${MARIA_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

# Stop MariaDB gracefully
mysqladmin -u root -p"${MARIA_ROOT_PASSWORD}" shutdown

# Start MariaDB in safe mode in the foreground
exec mysqld_safe
