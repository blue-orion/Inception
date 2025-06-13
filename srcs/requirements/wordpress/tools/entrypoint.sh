#!/bin/sh

CONFIG_PATH=/var/www/html/wp-config.php
sleep 7

if [ -f "$MYSQL_PASSWORD_FILE" ]; then
  export MYSQL_PASSWORD=$(cat /run/secrets/dp_password)
fi
if [ -f "$MYSQL_ROOT_PASSWORD_FILE" ]; then
  export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
fi
if [ -f "$WP_PASSWORD_FILE" ]; then
  export WP_PASSWORD=$(cat /run/secrets/wp_password)
fi

do
  echo "$VAR"
done

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
	--url=$DOMAIN_NAME	\
	--title=Inception 		\
	--admin_user=wpuser 	\
	--admin_password=wppassword \
	--admin_email=info@wp-cli.org

wp user create $WP_USER $WP_EMAIL --user_pass=$WP_PASSWORD --porcelain

wp plugin install https://downloads.wordpress.org/plugin/redis-cache.2.5.4.zip --activate

wp config set WP_REDIS_HOST redis
wp config set WP_REDIS_PORT 6379

wp redis update-dropin

wp config set WP_DEBUG true
wp config set WP_DEBUG_LOG true
wp config set DISALLOW_FILE_MODE false

exec php-fpm82 -F

