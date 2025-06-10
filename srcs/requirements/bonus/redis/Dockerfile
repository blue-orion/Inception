FROM alpine:3.21

RUN apk update  \
  && apk add --no-cache \
      curl  \
      redis

COPY conf/redis.conf /etc/redis.conf

EXPOSE 6379

ENTRYPOINT ["redis-server", "/etc/redis.conf"]
