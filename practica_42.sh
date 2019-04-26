#!/bin/bash
#Saúl Flores Benavente 755769
#Luis García Garcés 739202

user=as
if [ $(id -u) -eq 0 ]
then
     if [ $# -ne 3 ]
     then
            echo "Numero incorrecto de parametros"
    else
        if [ $1 == "-a" ]
        then
            oldIFS=$IFS
			IFS=,
			while read ip
			do
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
							ssh $user@$ip "sudo useradd -c "$nomC" $nombre -m -k /etc/skel -K UID_MIN=1815 -U 2> /dev/null"
							anyadido=$?
							if [ $anyadido -eq 9 ]
							then
									echo "El usuario $nombre ya existe"
							elif [ $anyadido -eq 0 ]
							then
								ssh $user@$ip "sudo usermod -f0 $nombre"
								ssh $user@$ip "echo "${nombre}:$contrasena" | sudo chpasswd"
								ssh $user@$ip "sudo passwd -x30 $nombre > /dev/null"
					 
								echo "$nomC ha sido creado"
							fi
						fi
					done < $2
				fi
			done < $3	
			IFS=$oldIFS      
        elif [ $1 == "-s" ]
        then
            oldIFS=$IFS
			IFS=','
			mkdir -p /extra/backup
			while read ip
			do
				ping -c 1 $ip > /dev/null 
				if [ $? -ne 0 ]
				then
					echo "$ip no es accesible"
				else
					while read nombre ignore
					do
						ssh $user@$ip "id $nombre 2> /dev/null > /dev/null"
						if [ $? -eq 0 ]
						then
							uhome=$(ssh $user@$ip "cat /etc/passwd | egrep "$nombre" | grep -o ":/[^:]*:" | tr -d ':'")
							ssh $user@$ip "tar -cf /extra/backup/$nombre.tar $uhome 2> /dev/null > /dev/null"
							if [ $? -eq 0 ]
							then
								ssh $user@$ip "sudo userdel -r $nombre 2> /dev/null"
							fi
						fi
					done < $2
				fi	
			done < $3
			IFS=$oldIFS  
        else
            echo "Opcion invalida" >&2
        fi
    fi
else
    echo "Este script necesita privilegios de administracion"
    exit 1
fi