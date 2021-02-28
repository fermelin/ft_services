#!/bin/sh

openrc default
/etc/init.d/mariadb setup
rc-service mariadb start
mysql -u root mysql < init_database.sql
mysql -u root wordpress < wordpress.sql
rc-service mariadb stop
/usr/bin/mysqld_safe --datadir='/var/lib/mysql'