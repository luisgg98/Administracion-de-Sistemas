#!/bin/bash
route add -net 192.168.2.0 netmask 255.255.255.0 dev enp0s3
route add default gw 192.168.2.1 dev enp0s3

#Maquina con IP dinamica