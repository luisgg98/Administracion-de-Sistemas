#!/bin/bash
route add -net 192.168.56.0 netmask 255.255.255.0 dev ethx
route add default gw 192.168.56.1 dev ethx
#¿Con esto bastaría para usar a debian1 de router?
