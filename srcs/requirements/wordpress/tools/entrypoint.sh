#!/bin/sh

CONFIG_PATH=/var/www/html/wp-config.php
sleep 10

if [ ! -f "$CONFIG_PATH" ]; then
	echo "[INFO] Generating wp-config.php..."
	wp config create	\
		--dbname=$MYSQL_DATABASE	\
		--dbuser=$MYSQL_USER		\
		--dbpass=$MYSQL_PASSWORD	\
		--dbhost=$DB_HOST
fi

echo "[INFO] Install wordpress..."
wp core install \
	--url=localhost:8443	\
	--title=Inception 		\
	--admin_user=wpuser 	\
	--admin_password=wppassword \
	--admin_email=info@wp-cli.org


exec php-fpm82 -F

