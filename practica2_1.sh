#!/bin/bash
echo -n "Introduzca el nombre del fichero: "
read fichero
if [ -f fichero ]
then
    echo "Los permisos del archivo $fichero son: $(ls -l $fichero | egrep -o "^...." | sed -e "s/^.//g")"
else
    echo "$fichero no existe"
fi 
exit 0