# Use Debian as base
FROM debian:bullseye

# Set working directory
WORKDIR /var/hugo/me

# Install dependencies including Go for building Hugo from source
RUN apt-get update && \
    apt-get install -y wget git gcc g++ make tar && \
    apt-get clean

# Install Go to build Hugo
RUN wget https://golang.org/dl/go1.23.0.linux-amd64.tar.gz -O go.tar.gz && \
    tar -C /usr/local -xzf go.tar.gz && \
    rm go.tar.gz

# Add Go to PATH
ENV PATH="/usr/local/go/bin:${PATH}"

# Clone Hugo repository and build Hugo extended version from source
RUN git clone --branch v0.135.0 https://github.com/gohugoio/hugo.git /hugo && \
    cd /hugo && \
    go install --tags extended && \
    cp /root/go/bin/hugo /usr/local/bin/hugo

# Initialize a new Hugo site and add the m10c theme
RUN hugo new site /var/hugo/me && \
    cd /var/hugo/me && \
    git clone https://github.com/vaga/hugo-theme-m10c themes/m10c && \
    hugo -b https://jedurand.42.fr/me

# Copy configuration files into the container
COPY ./conf/config.toml /var/hugo/me/config.toml
COPY ./conf/avatar.jpg /var/hugo/me/themes/m10c/static/avatar.jpg

# Expose the port Hugo will serve on
EXPOSE 1313

# Run Hugo server
CMD ["hugo", "server", \
     "--bind=0.0.0.0", \
     "--baseURL=https://jedurand.42.fr/me", \
     "-p", "1313", \
     "--appendPort=false"]
