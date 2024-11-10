FROM debian:bullseye

# Install MariaDB and set permissions
RUN apt-get update && \
    apt-get install -y mariadb-server && \
    chown -R mysql:mysql /var/lib/mysql && \
    chmod -R 750 /var/lib/mysql

# Copy configuration and startup scripts, then set permissions
COPY conf/mysqld.conf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/mariadb.sh && \
    echo "Check of mariadb.sh:" && \
    ls -l /usr/local/bin/mariadb.sh

CMD ["/usr/local/bin/mariadb.sh"]
