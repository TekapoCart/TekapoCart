#!/bin/sh

DIR="$1"

for f in $( find "$DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.gif' \)  );
do

    FILE=$(basename -- "$f")
    EXT="${FILE##*.}"
    NAME="${FILE%.*}"

#    if [ ! -f "${f%.$EXT}.webp" ]; then
#        imagemin --plugin.webp.quality=90 --plugin.webp.preset=icon $f > "${f%.$EXT}.webp"
#        echo "compress ${f%.$EXT}.webp"
#    fi


#    imagemin $f > "${f%.$EXT}-optimized.$EXT"
#    imagemin --plugin=pngquant $f > "${f%.$EXT}-optimized.$EXT"
#    imagemin --plugin=jpegtran $f > "${f%.$EXT}-optimized.$EXT"

done