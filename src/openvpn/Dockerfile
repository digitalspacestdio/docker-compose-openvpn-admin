FROM alpine:3.16
ARG TARGETARCH
RUN apk add --update --no-cache bash openvpn easy-rsa iptables  && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    wget https://github.com/pashcovich/openvpn-user/releases/download/v1.0.4/openvpn-user-linux-${TARGETARCH:-$(uname -m)}.tar.gz -O - | tar xz -C /usr/local/bin && \
    if [ -f "/usr/local/bin/openvpn-user-${TARGETARCH:-$(uname -m)}" ]; then ln -s /usr/local/bin/openvpn-user-${TARGETARCH:-$(uname -m)} /usr/local/bin/openvpn-user; fi
COPY setup/ /etc/openvpn/setup
RUN chmod +x /etc/openvpn/setup/entrypoint.sh
ENTRYPOINT [ "/etc/openvpn/setup/entrypoint.sh" ]
CMD openvpn --config /etc/openvpn/openvpn.conf --client-config-dir /etc/openvpn/ccd --port 1194 --proto udp --management 127.0.0.1 8989 --dev tun0 --server ${OVPN_SRV_NET} ${OVPN_SRV_MASK}
EXPOSE 1194/tcp 1194/udp