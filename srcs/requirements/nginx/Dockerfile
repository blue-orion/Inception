FROM alpine:3.21

RUN apk update \
	&& apk add --no-cache \
		nginx

RUN mkdir -p /etc/nginx/certs /run/nginx

COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY tools/mime.types /etc/nginx/mime.types
COPY tools/fastcgi_params /etc/nginx/fastcgi_params

WORKDIR /var/www/html

EXPOSE 443

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["nginx", "-g", "daemon off;"]
