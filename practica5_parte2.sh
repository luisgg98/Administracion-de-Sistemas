#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Numero de parametros incorrecto"
    exit 85
fi
ip=$1
if ! ping -c1 "$ip" > /dev/null
then
    echo "No se puede acceder a $ip"
    exit 1
fi

ssh as@ip sudo sfdisk -s
ssh as@ip sudo sfdisk -l
ssh as@ip sudo df -hT

echo "Fin del script"

