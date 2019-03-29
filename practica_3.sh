#!/bin/bash

leerBorrar(){
    oldIFS=$IFS
    IFS=,
    mkdir -p /extra/backup
    while read nombre ignore
    do
        echo "$nombre"
        tar -cvf /extra/backup/{$nombre}.tar /home/$home 2> /dev/null
        if [ $? -eq 0 ]
        then
            echo "HOLA"
             userdel -r $nombre 2> /dev/null
        fi
    done < $1
    IFS=$oldIFS      
}

if [ $(id -u) -eq 0 ]
then
     if [ $# -ne 2 ]
     then
            echo "Numero incorrecto de parametros"
    else
        if [ $1 == "-a" ]
        then
            //
        elif [ $1 == "-s" ]
        then
            leerBorrar $2
        else
            echo "Opcion invalida"  
        fi
    fi
else
    echo "Este script necesita privilegios de administracion"
    exit 1
fi
        
