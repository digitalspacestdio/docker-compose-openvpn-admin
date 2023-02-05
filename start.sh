#!/usr/bin/env bash

export OVPN_PUBLIC_IP=$(host myip.opendns.com resolver1.opendns.com | grep 'has address' | awk '{ print $4}')

docker-compose -p openvpn-master up -d --build
