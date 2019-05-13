#!/bin/bash
route add -net 192.168.57.0 netmask 255.255.255.0 dev ethx
route add default gw 192.168.57.1 dev ethx

#Maquina con una IP Dinamica