#!/bin/bash

apt-get update
apt-get install -y apache2

a2enmod proxy
a2enmod proxy_http

cp /vagrant/web-website.conf /etc/apache2/sites-available/

a2ensite web-website
a2dissite 000-default

service apache2 restart