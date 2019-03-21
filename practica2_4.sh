#!/bin/bash

echo -n "Introduzca una tecla: "
read -n 1 tecla
echo
case $tecla in 
    [a-z]|[Z-A])
    echo "$tecla es una letra";;
    [0-9])
    echo "$tecla es un numero";;
    *)
    echo "$tecla es un caracter especial";;
esac 
exit 0