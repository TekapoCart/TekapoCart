#!/bin/sh

git pull && chown www-data:www-data -R /var/www/html && rm -rf ./public/var/cache/prod/*