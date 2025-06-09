FROM alpine:3.21

RUN apk update \
	&& apk add --no-cache \
		nginx	\
		openssl	\
		ca-certificates \
		nss-tools

RUN curl -Lo mkcert https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-linux-amd64
RUN chmod +x mkcert
RUN mv mkcert /usr/local/bin/

RUN mkdir -p /etc/nginx/certs /run/nginx

# 설정 파일 및 인증서 복사
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/mime.types /etc/nginx/mime.types
COPY conf/fastcgi_params /etc/nginx/fastcgi_params

WORKDIR /var/www/html

EXPOSE 443

COPY conf/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

