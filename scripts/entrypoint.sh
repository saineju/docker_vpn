#!/bin/bash

SUPPORTED="openvpn openconnect"

if [[ -z ${TYPE} ]]; then
    echo "Please specify environment variable TYPE to define VPN type"
    echo "Currently supported types:"
    for i in ${SUPPORTED}; do
        echo ${i}
    done
    exit 1
fi

/usr/bin/microsocks ${MICROSOCS_PARAMS} &
sudo /scripts/start_vpn.sh ${TYPE}
