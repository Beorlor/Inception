#!/bin/sh

mysql_install_db
/etc/init.d/mysql start

if [ -d "/var/lib/mysql/$MARIA_DATABASE" ]; then
    echo "Database already exists"
else
    mysql_secure_installation << _EOF_
Y
$MARIA_ROOT_PASSWORD
$MARIA_ROOT_PASSWORD
Y
n
Y
Y
_EOF_

    echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIA_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
    echo "CREATE DATABASE IF NOT EXISTS $MARIA_DATABASE; GRANT ALL ON $MARIA_DATABASE.* TO '$MARIA_USER'@'%' IDENTIFIED BY '$MARIA_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
    mysql -uroot -p$MARIA_ROOT_PASSWORD $MARIA_DATABASE < /usr/local/bin/wordpress.sql
fi

/etc/init.d/mysql stop
exec "$@"
