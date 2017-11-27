#!/bin/bash

export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin

# if the route to wrangler is wrong, add it
if ! (route -n | grep 149.165.238.53) >/dev/null 2>&1; then
    logger "Fixing static route to Wrangler NFS"
    route add -net 149.165.238.53 netmask 255.255.255.255 gw 10.5.0.129
fi

