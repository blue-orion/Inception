FROM alpine:3.21

RUN apk update && apk add --no-cache \
	curl	\
	openssl	\
	php82	\
	php82-phar	\
	php82-fpm	\
	php82-mysqli	\
	php82-iconv		\
	php82-mbstring	\
  php82-redis     \
  php82-ctype     \
  php82-tokenizer \ 
	php82-openssl

WORKDIR /var/www/html

RUN curl -O -L https://github.com/vrana/adminer/releases/download/v5.3.0/adminer-5.3.0.php

COPY ./conf/php-fpm.conf /etc/php82/php-fpm.d/www.conf

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]
