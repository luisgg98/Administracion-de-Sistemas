#!/bin/bash
oldIFS=$IFS
IFS=$'\n'
echo -n "Introduzca el nombre del fichero: "
read fichero
if [ -f $fichero ]
then
    echo "Los permisos del archivo $fichero son: $(ls -l $fichero | cut -c 2-4)"
else
    echo "$fichero no existe"
fi 
IFS=$oldIFS
