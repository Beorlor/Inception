FROM debian:bullseye

# Install vsftpd
RUN apt-get update && \
    apt-get install -y vsftpd && \
    rm -rf /var/lib/apt/lists/*

# Copy configuration and entrypoint script
COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/server_ftp.sh /tmp/server_ftp.sh

# Set entrypoint script as the container's entrypoint
ENTRYPOINT ["sh", "/tmp/server_ftp.sh"]

# Expose the default FTP port and the range for passive mode
EXPOSE 21 21100-21110
