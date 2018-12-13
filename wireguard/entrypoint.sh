#!/bin/bash

set -e

cd /etc/wireguard

if ! compgen -G "/etc/wireguard/*.conf" > /dev/null; then
    echo "no config file at /etc/wireguard/*.conf – creating demo config"
    # Generate Server Private Keys
    umask 077
    wg genkey | tee server_private_key | wg pubkey > server_public_key
    # Setup Configuration wg0.conf
    sed -e "s-SERVER_PVTKEY-${server_pvtkey}-g" /wg0.conf.tpl > /etc/wireguard/wg0.conf
    sed -e "s-INTERFACE_ADDR-${interface_address}-g" /etc/wireguard/wg0.conf > /etc/wireguard/wg0.conf
    chown -v root:root /etc/wireguard/wg0.conf
    chmod -v 600 /etc/wireguard/wg0.conf
fi

server_pvtkey=$(cat server_private_key)




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
