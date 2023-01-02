FROM ubuntu:22.04

COPY scripts /scripts
RUN chmod +x /scripts/* && \
    apt-get update && \
    apt-get upgrade && \
    apt-get install -y openvpn microsocks net-tools sudo && \
    useradd -m default && \
    echo 'Defaults:default !requiretty' > /etc/sudoers.d/default && \
    echo 'default ALL=NOPASSWD:/scripts/create_device.sh' >> /etc/sudoers.d/default && \
    echo 'default ALL=NOPASSWD:/usr/sbin/openvpn --config /openvpn/ovpn.conf' >> /etc/sudoers.d/default

USER default
WORKDIR /openvpn

ENTRYPOINT /scripts/entrypoint.sh
