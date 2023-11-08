FROM alpine:3.16
ARG TARGETARCH
ENV OVPN_SERVER_NET=172.16.100.0
ENV OVPN_SERVER_MASK=255.255.255.0
RUN apk add --update --no-cache bash openvpn easy-rsa iptables python3 && \
    ln -s /usr/share/easy-rsa/easyrsa /usr/local/bin && \
    wget https://github.com/pashcovich/openvpn-user/releases/download/v1.0.4/openvpn-user-linux-${TARGETARCH:-$(uname -m)}.tar.gz -O - | tar xz -C /usr/local/bin && \
    if [ -f "/usr/local/bin/openvpn-user-${TARGETARCH:-$(uname -m)}" ]; then ln -s /usr/local/bin/openvpn-user-${TARGETARCH:-$(uname -m)} /usr/local/bin/openvpn-user; fi
COPY setup /etc/openvpn/setup
RUN chmod +x /etc/openvpn/setup/*
ENTRYPOINT [ "/etc/openvpn/setup/entrypoint.sh" ]
CMD openvpn --config /etc/openvpn/openvpn.conf --client-config-dir /etc/openvpn/ccd --port 1194 --proto udp --management 127.0.0.1 8989 --dev tun0 --server ${OVPN_SERVER_NET} ${OVPN_SERVER_MASK}
EXPOSE 1194/tcp 1194/udp
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 CMD /etc/openvpn/setup/check_openvpn -p 1194 --tls-auth /etc/openvpn/easyrsa/pki/ta.key 127.0.0.1