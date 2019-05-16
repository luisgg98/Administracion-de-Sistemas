#!/bin/bash

if [ "$#" -ne 1 ]
then
    echo "Numero de parametros incorrecto"
    exit 85
fi
ip=$(echo "$1" | cut -d '@' -f2)

if ! ping -c1 "$ip"  > /dev/null
then
    echo "No se puede acceder a la direccion: $ip"
    exit 1
fi

ssh "$1" "sudo sfdisk -s"
ssh "$1" "sudo sfdisk -l"
ssh "$1" "sudo df -hT"

