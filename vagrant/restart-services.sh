#!/usr/bin/env bash
#
# Restarts the apache2 and the php-fpm service
# (Shared folders are made available *after* the services start, and the Document-root is also a shared folder)
#
vagrant ssh -c "sudo service apache2 restart; sudo service php7.3-fpm restart; ps -ef | grep 'fpm\|apache2'"

