#!/bin/bash
route add -net 192.168.1.0 netmask 255.255.255.0 dev enp0s8
route add default gw 192.168.1.1 dev enp0s8
#¿Con esto bastaría para usar a debian1 de router?
