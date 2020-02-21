#!/bin/bash
#
#

# Avoid upgrading packages that requires interaction (the point of this bootstrap is to provide automated setup with no interaction)
apt-mark hold grub-common grub-pc grub-pc-bin grub2-common
apt-mark hold kbd keyboard-configuration
apt-mark hold sudo

apt-get update
apt-get upgrade -y

locale-gen "en_US.UTF-8"
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_MESSAGES=en_US.UTF-8 LC_ALL=en_US.UTF-8
update-alternatives --set editor /usr/bin/vim.basic

apt-get install -y ntp

add-apt-repository -y ppa:ondrej/php

apt-get update

apt-get install -y php7.3 php7.3-dev php7.3-zip php7.3-fpm php7.3-cli php7.3-curl php7.3-gd php7.3-intl php7.3-mbstring php7.3-xml
apt-get install -y php-msgpack php-gettext php-xdebug php-redis php-mongodb php-psr
apt-get install -y php7.3-phalcon

apt-get install -y gettext nodejs npm zip
apt-get install -y redis-server
apt-get install -y mongodb
apt-get install -y apache2

# phalcon repo
#curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
#apt-add-repository ppa:phalcon/stable -y
#apt-add-repository ppa:chris-lea/redis-server -y

# mongo repos
#apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
#echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# composer
curl -sS http://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
chown root:root /usr/local/bin/composer
chmod +x /usr/local/bin/composer

# phpunit
wget https://phar.phpunit.de/phpunit.phar -O /usr/local/bin/phpunit
chown root:root /usr/local/bin/phpunit
chmod +x /usr/local/bin/phpunit

# fix missing node symlink
ln -s /usr/bin/nodejs /usr/local/bin/node

systemctl start ntp.service

a2enmod setenvif actions rewrite

# fix npm permissions (https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally)
mkdir /home/vagrant/.npm-global
chown vagrant:vagrant /home/vagrant/.npm-global


npm config set prefix '/home/vagrant/.npm-global'
# ensure relevant bin/ folders is in our path (npm)
grep -q -F 'PATH="/home/vagrant/.npm-global/bin:$PATH"' /home/vagrant/.profile || echo 'PATH="/home/vagrant/.npm-global/bin:$PATH"' >> /home/vagrant/.profile

# install/update node dependencies
#npm install -g aglio


systemctl daemon-reload

systemctl restart apache2

# transfer php ini files to git control (not testing if ini file exists, assuming previous install actions succeeded)
if [[ ! -h /etc/php/7.3/fpm/php.ini ]]; then
	mv /etc/php/7.3/cli/php.ini /vagrant/php/php-cli.ini
	mv /etc/php/7.3/fpm/php.ini /vagrant/php/php.ini
fi
ln -fs /vagrant/php/php-cli.ini /etc/php/7.3/cli/php.ini
ln -fs /vagrant/php/php.ini /etc/php/7.3/fpm/php.ini

# enable sites
if [[ -h /etc/apache2/sites-enabled/000-default.conf ]]; then
	unlink /etc/apache2/sites-enabled/000-default.conf
fi
ln -fs /vagrant/default.conf /etc/apache2/sites-enabled/debroxy.vvb.conf

# ensure relevant bin/ folders is in our path (composer)
grep -q -F 'PATH="/var/www/debroxy/vendor/bin:$PATH"' /home/vagrant/.profile || echo 'PATH="/var/www/debroxy/vendor/bin:$PATH"' >> /home/vagrant/.profile

# unmark upgrade packages that requires interaction manually, so you can manually upgrade them via a terminal
apt-mark unhold grub-common grub-pc grub-pc-bin grub2-common
apt-mark unhold kbd keyboard-configuration
apt-mark unhold sudo



