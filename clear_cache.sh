#!/bin/sh


rm -rf ./public/var/cache/prod/*
rm -rf ./public/var/cache/dev/*

#rm -rf ./public/themes/simplicity/assets/cache/*
#rm -rf ./public/themes/simplicity/cache/*
        
#mysql -h $DB_SERVER -u $DB_USER -p$DB_PASSWD $DB_NAME -e "UPDATE ps_configuration SET value=value+1, date_upd=NOW() WHERE name ='PS_CCCJS_VERSION'";
#mysql -h $DB_SERVER -u $DB_USER -p$DB_PASSWD $DB_NAME -e "UPDATE ps_configuration SET value=value+1, date_upd=NOW() WHERE name ='PS_CCCCSS_VERSION'";