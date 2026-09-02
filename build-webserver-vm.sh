#!/bin/bash

apt-get update
apt-get install -y apache2

# Enable Apache proxy modules.
a2enmod proxy
a2enmod proxy_http

# Copy our website configuration.
cp /vagrant/web-website.conf /etc/apache2/sites-available/

# Enable our site and disable the default site.
a2ensite web-website
a2dissite 000-default

# Restart Apache.
service apache2 restart