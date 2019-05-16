#!/bin/bash

grupovolumen=$(echo $1 | cut -d ','  -f1)
volumenlogico=$(echo $1 | cut -d ','  -f2)
tamanyo=$(echo $1 | cut -d ',' -f3)
tsistemaficheros=$(echo $1 | cut -d ',' -f4)
directorio=$(echo $1 | cut -d ',' -f5)

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
		lvcreate -L "$tamanyo" --name "$volumenlogico" "$grupovolumen"
		mkfs -t "$tsistemaficheros" "$ruta"
		mount -t  "$tsistemaficheros" "$ruta" "$directorio"
		ID=$(sudo blkid "$ruta" | cut -d ' ' -f2 | cut -d '=' -f2  )
		sudo su -c "echo "$ID $directorio $tsistemaficheros errors=remount 0 2" >> /etc/fstab"
	else
		lvextend -L "$tamanyo" "$ruta"
		resize2fs "$ruta"
	fi
	
fi
