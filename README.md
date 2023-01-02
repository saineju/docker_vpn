# docker_vpn

This is an experimental setup to use dockers for VPN connections. 
Initially only openvpn is supported, but within time there migth be other VPN clients as well

The original idea is to use the container to connect to VPN and open a socks proxy through which
the resources behind the VPN can be accessed. Currently the container uses microsocks as the socks
proxy server, but it could just as easily include openssh server and that could be used to create
socks proxy instead.

This is still very much work in progress and requires further testing.

### Usage

First build the container

```
docker build -t openvpntest .
``` 

Currently the docker aims to connect to VPN directly and it expects to find openvpn related configurations
and other related files from /openvpn -directory and it currently expects that the vpn configuration file is
named ovpn.conf.

So starting would be something like this

```
docker run --rm --cap-add NET_ADMIN -v /path/to/openvpn:/openvpn -p 1080:1080 -it openvpntest
``` 

After this you should be able to configure your browser to use port 1080 as socks5 proxy and be able to
connect pages over VPN through that proxy. For convenience I prefer to use Firefox with multi account containers
plugin https://addons.mozilla.org/en-US/firefox/addon/multi-account-containers/, as you can configure a proxy
per container.

For SSH connection ssh ProxyCommand can be used

```
host testhost
  hostname <enter real hostname>
  ProxyCommand /usr/bin/nc -x 127.0.0.1:1080 %h %p
```

### ToDo

* Make things configurable (vpn config file, microsocks etc)
* Test user/password setups for VPN
