#!/bin/bash

dir=$( fin $HOME -maxdepth 1 -type d -name "bin[a-zZ-A0-9][a-zZ-A0-9][a-zZ-A0-9]")
fecha=""
destino=$HOME"/binTSM"
for i in $dir
do 
    if [ -n $i ]
    then
        if [ -z $fecha ]
        then
            destino=$i
            fecha=$( stat -c %Y $i )
        elif [ $fecha -gt $( stat -c %Y $i ) ]
        then
                fecha=$( stat -c %Y $i )
                destino=$i
        fi
    fi
done
if test -z $fecha ;
then
    mkdir $destino
    echo "Se ha creado el directorio $destino ."
fi
echo "Directorio destino de copia: $destino "

numero=0

for archivo in $( find . -maxdepth 1 -type f -executable )
do
    cp $archivo $destino
    echo "$archivo ha sido copiado a $destino"
    let numero+=1
done

if [ $numero -eq 0 ]
then    
    echo "No se ha copiado ningun fichero."
else
    echo "Se han copiado $numero archivos."
fi 
exit 0