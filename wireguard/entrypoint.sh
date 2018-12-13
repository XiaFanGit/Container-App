#!/bin/bash

set -e

cd /etc/wireguard

# Generate Server Private Keys

if ! compgen -G "/etc/wireguard/*.conf" > /dev/null; then
    echo "no config file at /etc/wireguard/*.conf – creating demo config"
    umask 077
    wg genkey | tee server_private_key | wg pubkey > server_public_key
    awk '/PrivateKey/ { print; print "ListenPort = 38945"; next }1' demo.conf > wg0.conf
    sed -i "s/0\.0\.0\.0\/0/192.168.4.1\/24/g" wg0.conf
fi



server_pvtkey=$(cat server_private_key)
$interface_address



# Install Wireguard. This has to be done dynamically since the kernel
# module depends on the host kernel version.
apt update
apt install -y linux-headers-$(uname -r)
apt install -y wireguard

# Find a Wireguard interface
interfaces=`find /etc/wireguard -type f`
if [[ -z $interfaces ]]; then
    echo "$(date): Interface not found in /etc/wireguard" >&2
    exit 1
fi

interface=`echo $interfaces | head -n 1`

echo "$(date): Starting Wireguard"
wg-quick up $interface

# Handle shutdown behavior
finish () {
    echo "$(date): Shutting down Wireguard"
    wg-quick down $interface
    exit 0
}

trap finish SIGTERM SIGINT SIGQUIT

sleep infinity &
wait $!
