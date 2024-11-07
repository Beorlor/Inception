FROM debian:bullseye

# Set working directory
WORKDIR /var/hugo/me

# Install required packages
RUN apt-get update && \
    apt-get install -y \
        hugo \
        git \
        passwd && \
    rm -rf /var/lib/apt/lists/*

# Initialize a new Hugo site and clone the theme
RUN hugo new site /var/hugo/me && \
    cd /var/hugo/me && \
    git clone https://github.com/vaga/hugo-theme-m10c themes/m10c && \
    hugo -b https://jedurand.42.fr/me

# Copy configuration files
COPY ./conf/config.toml /var/hugo/me/config.toml
COPY ./conf/avatar.jpg /var/hugo/me/themes/m10c/static/avatar.jpg

# Expose the port Hugo will serve on
EXPOSE 1313

# Run Hugo server
CMD ["hugo", "server", \
     "--bind=0.0.0.0", \
     "--baseURL=https://jedurand.42.fr/me", \
     "-p", "1313", \
     "--logFile=/dev/stdout", \
     "--appendPort=false"]
