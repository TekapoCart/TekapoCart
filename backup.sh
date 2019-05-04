#!/bin/sh

name=$(date '+%Y-%m-%d-%H-%M-%S')
tar -czvf "/var/bak/$name.tar.gz" ./public/img
mysqldump --databases tekapocart -h $DB_SERVER -u $DB_USER -p$DB_PASSWD   > "/var/bak/$name.sql"

