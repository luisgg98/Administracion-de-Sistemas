#!/bin/bash
route add -net 192.168.58.0 netmask 255.255.255.0 dev ethx
route add default gw 192.168.58.2 dev ethx

#Maquina que guarda el servidor ssh todo el trafico ha de llevarse a la pasarela