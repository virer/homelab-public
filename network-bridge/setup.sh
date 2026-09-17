#!/bin/bash

nmcli connection add type bridge con-name br0 ifname br0

NICNAME=`ip r | awk '/default via/ { print $5 }'`
nmcli connection add type ethernet port-type bridge con-name br0-port1 ifname $NICNAME controller br0

nmcli connection modify br0 ipv4.addresses '100.100.0.66/24' ipv4.gateway '100.100.0.1' ipv4.dns '100.100.0.1' ipv4.dns-search 'lab.virer.net' ipv4.method manual

# EOF
