# Use Debian Bullseye as the base image
FROM debian:bullseye

# Add the Sury repository for PHP 8.0 packages
RUN apt-get update && \
    apt-get install -y lsb-release gnupg curl && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list && \
    curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/sury-php.gpg && \
    apt-get update

# Install prerequisites and PHP 8.0 with necessary extensions
RUN apt-get install -y \
    curl \
    less \
    mariadb-client \
    php8.0 \
    php8.0-fpm \
    php8.0-common \
    php8.0-mbstring \
    php8.0-gd \
    php8.0-curl \
    php8.0-xml \
    php8.0-mysqli \
    php8.0-imap \
    php8.0-pdo \
    php8.0-pdo-mysql \
    php8.0-soap \
    php8.0-gettext \
    php8.0-ldap \
    php8.0-ctype \
    php8.0-dom \
    php8.0-simplexml && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Create required directories and set permissions
RUN mkdir -p /run/php && chown www-data:www-data /run/php

# Download Adminer and move it to the web root
RUN curl -L -O https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    mkdir -p /var/www/html && \
    mv ./adminer-4.8.1.php /var/www/html/index.php

# Copy custom PHP-FPM configuration
COPY /conf/www.conf /etc/php/8.0/fpm/pool.d/www.conf

# Expose port 9000 for PHP-FPM
EXPOSE 9000
STOPSIGNAL SIGQUIT

# Start PHP-FPM in the foreground
CMD ["php-fpm8.0", "--nodaemonize"]
