FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y apache2 php php-mbstring php-xml php-curl php-zip php-mysql wget && \
    apt-get clean

RUN wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" -O /var/www/html/adminer.php

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    sed -i 's/Listen 80/Listen 9000/' /etc/apache2/ports.conf && \
    sed -i 's/:80>/:9000>/' /etc/apache2/sites-available/000-default.conf && \
    a2enmod rewrite

EXPOSE 9000

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
