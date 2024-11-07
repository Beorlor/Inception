FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y redis && \
    rm -rf /var/lib/apt/lists/*

COPY ./tools/redis.sh /tmp/redis.sh

EXPOSE 6379

CMD ["sh", "/tmp/redis.sh"]
