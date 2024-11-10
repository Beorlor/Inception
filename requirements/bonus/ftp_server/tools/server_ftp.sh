#!/bin/sh

mkdir -p /var/run/vsftpd/empty
mkdir -p /etc/vsftpd

# Check if the vsftpd configuration has already been set up
if [ ! -f "/etc/vsftpd/vsftpd.conf.bak" ]; then
    # Create backup of the default vsftpd configuration
    cp /etc/vsftpd.conf /etc/vsftpd/vsftpd.conf.bak

    # Add FTP user and configure permissions for the WordPress directory
    adduser --disabled-password --gecos "" "$FTP_USER"
    echo "$FTP_USER:$FTP_PASS" | chpasswd
    chown -R "$FTP_USER:$FTP_USER" /var/www/html

    # Update vsftpd user list to include the new FTP user
    echo "$FTP_USER" > /etc/vsftpd.userlist
fi

# Start vsftpd in the foreground
echo "FTP server starting on port 21"
vsftpd /etc/vsftpd.conf
