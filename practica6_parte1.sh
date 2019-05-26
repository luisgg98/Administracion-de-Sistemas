#!/bin/bash

#Autores: Saúl Flores Benavente 755769
#		  Luis García Garcés 739202

if [ $# -ne 1 ]; then #Si el numero de paramtros es incorrecto
	echo "Numero de parametros incorrecto"
	exit 1
else
ip=$1
#El script va monitorizar la información tanto de la máquina local como de la remota 
#Empezamos monitorizando la máquina local
	logger -p local0.info "Informacion Maquina local:"

	logger -p local0.info "Numero de usuarios y carga media de trabajo:"
	 uptime | logger -p local0.info

	logger -p local0.info "Memoria ocupada y libre, y swap usado:"
	 free | logger -p local0.info

	logger -p local0.info "Espacio ocupado y libre:"
	 df | logger -p local0.info

	logger -p local0.info "Puertos abiertos y conexiones establecidas:"
	 netstat | logger -p local0.info

	logger -p local0.info "Numero de programas en ejecucion:"
	 ps | logger -p local0.info

#Ahora se guarda la monitorizacion de la maquina remota
	logger -p local0.info "Informacion Maquina remota "${ip}""

	logger -p local0.info "Numero de usuarios y carga media de trabajo:"
	ssh "${ip}" "uptime" | logger -p local0.info

	logger -p local0.info "Memoria ocupada y libre, y swap usado:"
	ssh "${ip}" " free" | logger -p local0.info

	logger -p local0.info "Espacio ocupado y libre:"
	ssh "${ip}" " df" | logger -p local0.info

	logger -p local0.info "Puertos abiertos y conexiones establecidas:"
	ssh "${ip}" " netstat" | logger -p local0.info

	logger -p local0.info "Numero de programas en ejecucion:"
	ssh "${ip}" " ps" | logger -p local0.info
fi
