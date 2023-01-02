#!/bin/bash

if [ ! -f /dev/net/tun ]; then
    sudo /scripts/create_device.sh
fi

/usr/bin/microsocks &
sudo /usr/sbin/openvpn --config /openvpn/ovpn.conf
