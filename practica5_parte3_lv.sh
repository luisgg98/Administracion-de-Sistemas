#!/bin/bash

#Grupo 422
#Luis García Garcés 739202
#Saúl Flores Benavente 755769

while read -p ">" lectura
do
	
	if [ "$lectura" == "quit" ]
	then
		echo "Final"
		exit 1
	fi
	echo "$lectura"
	grupovolumen=$(echo $lectura | cut -d ','  -f1)
	volumenlogico=$(echo $lectura | cut -d ','  -f2)
	tamanyo=$(echo $lectura | cut -d ',' -f3)
	tsistemaficheros=$(echo $lectura | cut -d ',' -f4)
	directorio=$(echo $lectura | cut -d ',' -f5)

	ruta="/dev/${grupovolumen}/${volumenlogico}"
	echo $ruta
	#No existe
	exite=$( sudo vgscan | grep "$grupovolumen")

	if [ -z "$exite" ]
	then
		echo "No existe el grupo: $grupovolumen"
		exit 1

	else	
		exite=$(sudo lvscan | grep "$ruta" )
		echo "$exite"
		if [  -z "$exite"  ]
		then
			sudo lvcreate -L "$tamanyo" --name "$volumenlogico" "$grupovolumen"
			sudo mkfs -t "$tsistemaficheros" "$ruta"
			if [ ! -d "$directorio" ]
			then	
				echo "Creando directorio: $directorio"
				sudo mkdir "$directorio"
			fi
			sudo mount -t  "$tsistemaficheros" "$ruta" "$directorio"
			ID=$(sudo blkid "$ruta" | cut -d ' ' -f2 | cut -d '=' -f2  )
			sudo su -c "echo "$ID $directorio $tsistemaficheros errors=remount 0 2" >> /etc/fstab"
		else
			sudo lvextend -L "$tamanyo" "$ruta"
			sudo resize2fs "$ruta"
		fi
	
	fi
done
