#!/bin/bash
route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.3.5 dev enp0s8
route add default gw 192.168.2.1 dev enp0s3

#Pasarela que comunica la maquina 5 con debian1