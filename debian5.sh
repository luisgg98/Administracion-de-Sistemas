#!/bin/bash
route add -net 192.168.3.0 netmask 255.255.255.0 dev enp0s3
route add default gw 192.168.3.6 dev enp0s3

#Maquina que guarda el servidor ssh todo el trafico ha de llevarse a la pasarela