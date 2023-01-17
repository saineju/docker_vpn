FROM ubuntu:22.04

COPY scripts /scripts
RUN chmod +x /scripts/* && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y openvpn openconnect microsocks net-tools sudo && \
    useradd -m default && \
    echo 'Defaults:default !requiretty' > /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += OPENVPN_CONFIG_PATH' >> /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += OPENCONNECT_URL' >> /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += OPENCONNECT_PARAMS' >> /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += VPN_USER' >> /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += OTP_CODE' >> /etc/sudoers.d/default && \
    echo 'Defaults    env_keep += ASK_OTP' >> /etc/sudoers.d/default && \
    echo 'default ALL=NOPASSWD:/scripts/start_vpn.sh' >> /etc/sudoers.d/default

USER default
WORKDIR /openvpn

ENTRYPOINT /scripts/entrypoint.sh
