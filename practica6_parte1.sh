#!/bin/bash

#Autores: Sa�l Flores Benavente 755769
#		  Luis Garc�a Garc�s 739202
#Empezamos monitorizando la m�quina local
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
