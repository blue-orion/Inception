#!/bin/sh

mkdir -p /etc/nginx/certs
cd /etc/nginx/certs

openssl genrsa -out 42CA.key 2048
openssl req -new -key 42CA.key -out 42CA.csr	\
	-subj "/C=KR/ST=Gyeonsan/L=Gyeonsan/O=42/OU=42/CN=localhost"
openssl x509 -req -in 42CA.csr -signkey 42CA.key -out 42CA.crt

openssl genrsa -out server.key 2048
openssl req -new -key server.key -out server.csr	\
	-subj "/C=KR/ST=Gyeonsan/L=Gyeonsan/O=42/OU=42/CN=localhost"
openssl x509 -req -in server.csr -CA 42CA.crt -CAkey 42CA.key -CAcreateserial -out server.crt

mkcert -install
mkcert localhost

cd /var/www/html

nginx -g "daemon off;"
