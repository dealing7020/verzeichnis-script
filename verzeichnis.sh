#!/bin/bash

set +x
VERZEICHNIS=$PWD

if [ ! -d "$1" ] && [ "$1" != '' ]; then
    echo "###############################################################"
    echo "# Parameter \""$1"\" ist kein Verzeichnis.                    #"
    echo "# Bitte geben sie ein gültiges Verzeichnis an.                #"
    echo "# Lassen Sie den Parameter weg,                               #"
    echo "# um Ihr derzeitiges Verzeichnis als Ausgangspunkt zu nutzen. #"
    echo "###############################################################"
    exit
fi

if [ -d "$1" ]; then
    VERZEICHNIS="$1"
fi

TEMP=$(mktemp)
for i in {2..99}; do
    ORDNER=$(echo "$VERZEICHNIS" | cut -d/ -f $i)
    if [ "$ORDNER" = '' ]; then
        break
    fi
    paste -d\" - - <<<"$ORDNER" | tr -d '\n' >>"$TEMP"
done

cat "$TEMP"
echo ''
rm -f "$TEMP"
exit
