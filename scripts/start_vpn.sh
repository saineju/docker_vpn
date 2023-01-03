#!/bin/bash

TYPE=$1
env
openconnect() {
    if [ -z "${OPENCONNECT_URL}" ]; then
        echo "You need to specify at least OPENCONNECT_URL environment variable when using openconnect"
        exit 1
    fi
    /usr/sbin/openconnect ${OPENCONNECT_PARAMS} ${OPENCONNECT_URL}
}

openvpn() {
    if [ ! -f /dev/net/tun ]; then
        /scripts/create_device.sh
    fi
    /usr/sbin/openvpn --config ${OPENVPN_CONFIG_PATH:-/openvpn/ovpn.conf}
}

case ${TYPE} in
  openvpn)
    openvpn
  ;;
  openconnect)
    openconnect
  ;;
esac
