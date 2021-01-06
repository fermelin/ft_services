#!/bin/sh

# service mysql start
# service php7.3-fpm start
# ssh-keygen -A

/usr/bin/supervisord -c /etc/supervisord.conf

# nginx -g 'daemon off;'
