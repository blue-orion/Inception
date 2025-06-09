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
	php82-openssl

COPY ./conf/php-fpm.conf /etc/php82/php-fpm.d/www.conf

WORKDIR /var/www/html

RUN curl -O https://wordpress.org/latest.tar.gz \
    && tar -xzf latest.tar.gz \
    && cp -r wordpress/* . \
    && rm -rf wordpress latest.tar.gz

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar	\
	&& chmod +x wp-cli.phar	\
	&& mv /usr/bin/php82 /usr/bin/php	\
	&& mv wp-cli.phar /usr/local/bin/wp

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/var/www/html"]

EXPOSE 9000

ENTRYPOINT ["/entrypoint.sh"]

