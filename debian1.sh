#!/bin/bash
route add -net 192.168.1.0 netmask 255.255.255.0 dev enp0s8
route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.2.6 dev enp0s8
route add -net 192.168.2.0 netmask 255.255.255.0 dev enp0s9 #servidor dhcp
route add default gw 10.0.2.15 dev enp0s3
#¿Una red para el administrador? 