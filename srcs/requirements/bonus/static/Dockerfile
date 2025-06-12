FROM alpine:3.21

RUN apk update \
  && apk add --no-cache \
      nginx

COPY conf/nginx_default.conf /etc/nginx/http.d/default.conf
COPY tools/crossy_road.html /var/www/html/crossy_road.html
COPY tools/crossy_road.css /var/www/html/crossy_road.css
COPY tools/crossy_road.js /var/www/html/crossy_road.js

WORKDIR /var/www/html

EXPOSE 2424

ENTRYPOINT ["nginx", "-g", "daemon off;"]
