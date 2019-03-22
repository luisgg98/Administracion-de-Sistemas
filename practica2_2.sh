#!/bin/bash
oldIFS=$IFS
IFS=$'\n'
for letra in "$@"
do
    if [ -f "$letra" ]
    then
        more $letra
    else
        echo "$letra no es un fichero"
    fi
done
IFS=$oldIFS
exit 0
