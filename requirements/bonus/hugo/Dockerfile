FROM debian:bullseye

# Install required dependencies
RUN apt-get update && \
    apt-get install -y wget git gcc g++ make tar unzip && \
    apt-get clean

# Download and install the correct Go binary for x86-64
RUN wget https://golang.org/dl/go1.23.0.linux-amd64.tar.gz -O go.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

# Configure PATH for Go
ENV PATH="/usr/local/go/bin:${PATH}"

# Clone Hugo repository and build from source
RUN git clone --branch v0.135.0 https://github.com/gohugoio/hugo.git /hugo && \
    cd /hugo && \
    go install --tags extended

# Move the Hugo binary to a directory in PATH
RUN cp /root/go/bin/hugo /usr/local/bin/hugo

# Set the working directory for the Hugo site
WORKDIR /site

# Copy configuration and content for the Hugo site
COPY conf /site

# Install the Ananke theme
RUN mkdir -p /site/themes && \
    wget https://github.com/theNewDynamic/gohugo-theme-ananke/archive/refs/heads/master.zip -O ananke.zip && \
    unzip ananke.zip -d /site/themes && \
    mv /site/themes/gohugo-theme-ananke-master /site/themes/ananke && \
    rm ananke.zip

# Build the Hugo site
RUN hugo --baseURL="https://jedurand.42.fr/me"

# Expose Hugo's default port
EXPOSE 1313

# Serve the Hugo site
CMD ["hugo", "server", "--bind=0.0.0.0", "--baseURL=https://jedurand.42.fr/me", "--appendPort=false"]
