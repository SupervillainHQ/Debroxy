#!/usr/bin/env bash

#
# make executable and move to bin
#

if [[ -f /var/www/debroxy.vvb/build/debroxy.phar ]]; then
	chmod +x /var/www/debroxy.vvb/build/debroxy.phar
	mv /var/www/debroxy.vvb/build/debroxy.phar /var/www/debroxy.vvb/bin/debroxy
fi