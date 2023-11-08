# Docker Compose Openvpn with Admin WEBGUI

To start vpn server clone this repo and run docker compose
```
OVPN_PUBLIC_HOST=example.com TRAEFIK_BIND_PORT=8181 docker compose up -d
```