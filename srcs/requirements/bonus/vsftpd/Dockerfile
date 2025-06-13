FROM alpine:3.21

RUN apk update  \
  && apk add --no-cache \
      vsftpd

RUN adduser -D -h /home/ftpuser ftpuser \
    && echo "ftpuser:ftppass" | chpasswd

RUN mkdir -p /home/ftpuser

RUN mkdir -p /var/run/vsftpd/empty

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf

EXPOSE 21 30000-30009

WORKDIR /home/ftpuser

COPY tools/entrypoint.sh /entrypoint.sh
RUN chmod 700 /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
