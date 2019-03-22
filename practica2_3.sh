#!/bin/bash
oldIFS=$IFS
IFS=$'\n'
if [ $# -eq 1 ]
then
        if [ -f $1 ]
        then
            chmod u+x $1
            chmod g+x $1
            stat -c%A $1
        else
        echo "$@ no existe"
        fi
else
    echo "Sintaxis: practica2_3.sh <nombre_archivo>"
fi
IFS=$oldIFS
exit 0
