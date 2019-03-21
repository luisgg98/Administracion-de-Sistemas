#!/bin/bash
echo -n "Introduzca el nombre de un directorio: "
read directorio
oldIFS=$IFS 
IFS=$'\n'
if [ -d $directorio ]
then file=0
     dir=0
     for i in $(ls $directorio/)
     do
        echo "$i"
        if [ -f ${directorio}/$i ]
        then    
            let file+=1
        elif [ -d ${directorio}/$i ]
        then
            let dir+=1
        else
            echo "No es lo que buscamos"
        fi
    done
    echo -n "El numero de ficheros y directorios en $directorio es de "
    echo "$file y $dir , respectivamente"
else
    echo "$directorio no es un directorio"
fi

IFS=$oldIFS
exit 0
