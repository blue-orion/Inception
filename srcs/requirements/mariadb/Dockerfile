FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash

COPY conf/my.cnf /etc/my.cnf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

