#!/bin/sh

git pull && chown www-data:www-data -R . && rm -rf ./public/var/cache/prod/*