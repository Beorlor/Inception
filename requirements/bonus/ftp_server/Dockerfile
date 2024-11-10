FROM debian:bullseye

# Install vsftpd and other necessary packages
RUN apt-get update && \
    apt-get install -y vsftpd && \
    mkdir -p /var/run/vsftpd/empty && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and entrypoint script
COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/server_ftp.sh /usr/local/bin/server_ftp.sh
RUN chmod +x /usr/local/bin/server_ftp.sh

# Expose the FTP port and passive mode range
EXPOSE 21 21100-21110

# Set entrypoint
ENTRYPOINT ["sh", "/usr/local/bin/server_ftp.sh"]
