#!/bin/bash
route add -net 192.168.58.0 netmask 255.255.255.0 gw 192.168.58.2 dev ethx
route add default gw 192.168.57.1 dev ethx

#Pasarela que comunica la maquina 5 con debian1