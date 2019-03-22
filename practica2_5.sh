
#Autores 
#Luis García Garcés 739202
#Saúl Flores Benavente 755769

#!/bin/bash
oldIFS=$IFS
IFS=$'\n'
echo -n "Introduzca el nombre de un directorio: "
read directorio
if [ -d $directorio ]
then file=0
     dir=0
     for i in $(ls $directorio/)
     do
        if [ -d ${directorio}/$i ]
        then
            let dir+=1
        elif [ -f ${directorio}/$i ]
		then
			let file+=1
        fi
    done
    echo -n "El numero de ficheros y directorios en $directorio es de "
    echo "$file y $dir, respectivamente"
else
    echo "$directorio no es un directorio"
fi

IFS=$oldIFS
exit 0
