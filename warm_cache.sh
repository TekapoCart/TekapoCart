#!/bin/bash

for i in $(ls public/*_index_sitemap.xml); do

    f=$(cat $i | egrep -o "https:\/\/[^] \"\(\)\<\>]*")
    echo $f

    # --no-check-certificate
    wget --quiet $f --no-cache --output-document - | grep '<loc>' | egrep -o "https:\/\/[^] \"\(\)\<\>]*" | while read line; do
        time curl -A 'Cache Warmer' -s -L $line > /dev/null 2>&1
        echo $line
    done

done



