FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y nginx openssl && \
    apt-get clean

RUN mkdir -p /etc/nginx/ssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/nginx/ssl/jedurand.crt \
    -keyout /etc/nginx/ssl/jedurand.key \
    -subj "/C=FR/ST=Occitanie/L=Perpignan/O=42/OU=jedurand/CN=jedurand.42.fr"

COPY ./conf/nginx.conf /etc/nginx/conf.d

RUN mkdir -p /run/nginx

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]
