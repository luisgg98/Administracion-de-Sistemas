#!/bin/bash
route add -net 192.168.56.0 netmask 255.255.255.0 dev ethx
route add -net 192.168.58.0 netmask 255.255.255.0 gw 192.168.57.3 dev ethx2
route add -net 192.168.57.0 netmask 255.255.255.0 dev ethx #servidor dhcp
route add default gw #internet dev ethinternet
#¿Una red para el administrador? 