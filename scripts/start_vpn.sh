#!/bin/bash

TYPE=$1

if [ -z ${VPN_USER} ]; then
    read -p "Enter username for vpn: " VPN_USER
fi
read -sp "Enter password for vpn: " password
echo
openconnect() {
    if [ -z "${OPENCONNECT_URL}" ]; then
        read -p "Enter openconnect url: " OPENCONNECT_URL
    fi
    echo ${password} | /usr/sbin/openconnect ${OPENCONNECT_URL} -u ${VPN_USER} --non-inter --passwd-on-stdin "${OPENCONNECT_PARAMS}"
}

openvpn() {
    if [ ! -f /dev/net/tun ]; then
        /scripts/create_device.sh
    fi
    if [ ! -z "${ASK_OTP}" ]; then
        read -sp "Enter OTP Code: " OTP_CODE
    fi

    if [ ! -z "${OTP_CODE}" ]; then
        password=${password}${OTP_CODE}
    fi
    /usr/sbin/openvpn --config ${OPENVPN_CONFIG_PATH:-/openvpn/ovpn.conf} --auth-user-pass <(echo -e "$VPN_USER\n$password")
}

case ${TYPE} in
  openvpn)
    openvpn
  ;;
  openconnect)
    openconnect
  ;;
esac
