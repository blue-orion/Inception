FROM alpine:3.21

RUN apk update \
  && apk add --no-cache \
      nginx

COPY conf/nginx_default.conf /etc/nginx/http.d/default.conf
COPY tools/index.html /var/www/html/index.html

WORKDIR /var/www/html

EXPOSE 2424

ENTRYPOINT ["nginx", "-g", "daemon off;"]
