#!/bin/bash
# dhclient change script

export
set -x

if [ "x$reason" = "xBOUND" ]; then
    echo new_ip_address=$new_ip_address
    echo new_host_name=$new_host_name
    echo new_domain_name=$new_domain_name

    # only do this for the 10.5 addresses
    if ! (echo $new_ip_address | egrep '^10\.5') >/dev/null 2>&1; then
        exit 0
    fi

    logger "Fixing static route to Wrangler NFS"
    route add -net 149.165.238.53 netmask 255.255.255.255 gw 10.5.0.129
fi

