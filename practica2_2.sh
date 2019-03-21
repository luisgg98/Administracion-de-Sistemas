#!/bin/bash
for letra in "$@"
do
    if [ -f "$letra" ]
    then
        more $letra
    else
        echo "$letra no es un fichero"
    fi
done
exit 0