#!/bin/bash

apt-get -y install mysql-server
service mysql start
mysql -uroot -e "create database openeyes;"
mysql -uroot -e "create user 'openeyes' identified by 'oe_test'; grant all privileges on openeyes.* to 'openeyes'@'%' identified by 'oe_test'; flush privileges;"

git clone --depth=1 https://github.com/openeyes/OpenEyes.git /openeyes
chmod 777 /openeyes/protected
mkdir /openeyes/protected/runtime && chmod 777 /openeyes/protected/runtime
chmod 777 /openeyes/assets
chmod 777 /openeyes/protected/files
cp /openeyes/index.example.php /openeyes/index.php
cp /openeyes/.htaccess.sample /openeyes/.htaccess
mkdir /openeyes/protected/config/local
cp /src/common.php /openeyes/protected/config/local/common.php

php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/openeyes
cd /openeyes && ./composer.phar install --no-dev

service mysql start
echo "Creating test data..."
mysql -uroot -D openeyes < /src/openeyes_testdata.sql
echo "Finished creating test data..."
/openeyes/protected/yiic migrate --interactive=0
/openeyes/protected/yiic migratemodules --interactive=0

rm -rf /openeyes