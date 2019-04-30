#!/bin/bash
#Saúl Flores Benavente 755769
#Luis García Garcés 739202

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
					echo $nombre
					uhome=$(ssh -n user@$ip "cat /etc/passwd | grep "${nombre}:" | cut -d ':' -f 6")
					echo "soy $uhome"
					echo adios
					ssh -n user@$ip "sudo tar -cvf /extra/backup/${nombre}.tar $uhome 2> /dev/null > /dev/null"
					if [ $? -eq 0 ]
					then
						echo "Eliminando"
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
				echo "$nombre" "$contrasena" $nomC
				if [[ -z "$nombre" || -z "$contrasena" || -z "${nomC}" ]]
				then
					echo "Campo invalido"
				else
					ssh -n  user@$ip "sudo useradd -c "$nomC" $nombre -m -k /etc/skel -K UID_MIN=1815 -U 2> /dev/null"
					anyadido=$?
					echo $anyadido
					if [ $anyadido -eq 9 ]
					then
							echo "El usuario $nombre ya existe"
					elif [ $anyadido -eq 0 ]
					then
						echo añadido
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
