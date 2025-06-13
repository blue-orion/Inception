#!/bin/sh

if [ -f "$MYSQL_PASSWORD_FILE" ]; then
  export MYSQL_PASSWORD=$(cat /run/secrets/dp_password)
fi
if [ -f "$MYSQL_ROOT_PASSWORD_FILE" ]; then
  export MYSQL_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
fi

if [ ! -d /var/lib/mysql/mysql ]; then
    mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

    mysqld_safe --skip-networking &
    sleep 1

    mysql --protocol=socket -u root << EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

    mysqladmin -u root shutdown
    sleep 1
fi

chown -R mysql:mysql /var/lib/mysql

exec mysqld_safe

