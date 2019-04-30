#!/bin/bash
#Sa�l Flores Benavente 755769
#Luis Garc�a Garc�s 739202

#Uso: sudo ./practica_4.sh  [-a|-s] <fichero_usuarios> <fichero_máquinas> 
#OPCIONES
#   -a	 Añade los usuarios del fichero al sistema
#   -s	 Elimina los usuarios del fichero del sistema
#<fichero_usuarios>
#  El fichero, para añadir debe contener por cada linea:
#	nombre,contraseña,nombreCompleto
#  Para eliminar, puede o no contener la contraseña:
#       nombre
#<fichero_máquinas>
#  El fichero debe contener una direccion ip por cada linea
#
#Explicacion:Script para añadir o eliminar los usuarios que hay en el
#            FICHERO_USUARIOS en todas las ips de las maquinas que ha
#            en <fichero_máquinas>

leerBorrar(){
    oldIFS=$IFS
    IFS=,
	while read ip
	do
		echo "$ip"
		ping -c 1 $ip > /dev/null
		if [ $? -ne 0 ]
		then
			echo "$ip no es accesible"
		else
			ssh -n user@$ip "sudo mkdir -p /extra/backup"
			while read nombre ignore
			do
				ssh -n user@$ip "id $nombre 2> /dev/null > /dev/null"
				if [ $? -eq 0 ]
				then
					uhome=$(ssh -n user@$ip "cat /etc/passwd | grep "${nombre}:" | cut -d ':' -f 6")
					ssh -n user@$ip "sudo tar -cvf /extra/backup/${nombre}.tar $uhome 2> /dev/null > /dev/null"
					if [ $? -eq 0 ]
					then
						ssh -n user@$ip "sudo userdel -r $nombre 2> /dev/null"
					fi
				fi
			done < $1
		fi
	done < $2
    IFS=$oldIFS
}

leerInsertar(){
    oldIFS=$IFS
    IFS=,
	while read ip
	do
		echo $ip
		ping -c 1 $ip > /dev/null 
		if [ $? -ne 0 ]
		then
			echo "$ip no es accesible"
		else
			while read nombre contrasena nomC
			do
				if [[ -z "$nombre" || -z "$contrasena" || -z "${nomC}" ]]
				then
					echo "Campo invalido"
				else
					ssh -n  user@$ip "sudo useradd -c "$nomC" $nombre -m -k /etc/skel -K UID_MIN=1815 -U 2> /dev/null"
					anyadido=$?
					if [ $anyadido -eq 9 ]
					then
							echo "El usuario $nombre ya existe"
					elif [ $anyadido -eq 0 ]
					then
						ssh -n user@$ip "sudo usermod -f0 $nombre"
						ssh -n user@$ip "echo "${nombre}:$contrasena" | sudo chpasswd"
						ssh -n user@$ip "sudo passwd -x30 $nombre > /dev/null"
						echo "$nomC ha sido creado"
					fi
				fi
			done < $1
		fi
	done < $2
    IFS=$oldIFS
}



if [ $(id -u) -eq 0 ]
then
     if [ $# -ne 3 ]
     then
            echo "Numero incorrecto de parametros"
    else
        if [ $1 == "-a" ]
        then
            leerInsertar $2 $3
        elif [ $1 == "-s" ]
        then
            leerBorrar $2 $3
        else
            echo "Opcion invalida" >&2
        fi
    fi
else
    echo "Este script necesita privilegios de administracion"
    exit 1
fi