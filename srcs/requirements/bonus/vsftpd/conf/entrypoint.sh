#!/bin/sh

chown -R ftpuser:ftpuser /home/ftpuser

exec /usr/sbin/vsftpd /etc/vsftpd/vsftpd.conf
