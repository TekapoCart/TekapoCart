#!/bin/sh

DIR=./public/img/p

for f in $( find "$DIR" -type f -exec du -Sh {} + | sort -rh | head -n 5 | awk '{print $2;}' );
do

    ORIG_FILE=$(basename -- "$f")
    NAME="${ORIG_FILE%.*}"
    EXT="${ORIG_FILE##*.}"
    LARGE_FILE="$NAME-large_default.$EXT"
    FOLDER=$(dirname $f)

    if test -f "$FOLDER/$LARGE_FILE"; then

        printf "$FOLDER/$ORIG_FILE\n"
        printf "$FOLDER/$LARGE_FILE\n"

        cp "$FOLDER/$LARGE_FILE" "$FOLDER/$ORIG_FILE"
    fi

done
