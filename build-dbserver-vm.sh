#!/bin/bash

apt-get update
apt-get -y install mysql-server

service mysql start

echo "CREATE DATABASE IF NOT EXISTS todo;" | mysql

echo "CREATE USER IF NOT EXISTS 'user'@'192.168.56.11' IDENTIFIED BY 'password';" | mysql

echo "GRANT ALL PRIVILEGES ON todo.* TO 'user'@'192.168.56.11';" | mysql
echo "FLUSH PRIVILEGES;" | mysql

cat /vagrant/setup-database.sql | mysql todo

sed -i'' -e '/bind-address/s/127.0.0.1/0.0.0.0/' /etc/mysql/mysql.conf.d/mysqld.cnf

service mysql restart