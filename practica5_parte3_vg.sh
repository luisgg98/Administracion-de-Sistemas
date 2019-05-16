#!/bin/bash

if [ $# -lt 2 ]
then
	echo "Numero incorrecto de parametros"
	exit 85
fi

grupo="$1"
shift 1 
particiones=$@

for file in $particiones
do
	echo "$file"
     	sudo pvcreate -f "${file}"
	if [ $? -eq 5 ]
	then
		echo "Particion montada o ya forma parte de un grupo volumen"
	else
		sudo vgextend "${grupo}" "${file}"
	fi
done

