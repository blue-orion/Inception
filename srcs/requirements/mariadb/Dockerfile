FROM alpine:3.21

RUN apk update && apk add --no-cache mariadb mariadb-client bash

COPY conf/my.cnf /etc/my.cnf
COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# 환경변수 기본값 (docker-compose에서도 덮어씀)
ENV MYSQL_DATABASE=wordpress \
    MYSQL_USER=wpuser \
    MYSQL_PASSWORD=wppassword \
    MYSQL_ROOT_PASSWORD=rootpassword

VOLUME ["/var/lib/mysql"]

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

