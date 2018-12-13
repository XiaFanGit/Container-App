#!/bin/bash

set -e

cd /etc/wireguard

function CreatWg0() {
	cp /wg0.conf.tpl /etc/wireguard/wg0.conf
	sed -i "s/SERVER_PVTKEY/${server_pvtkey}/g" /etc/wireguard/wg0.conf
	sed -i "s/INTERFACE_ADDR/${interface_addr}/g" /etc/wireguard/wg0.conf
}

if ! compgen -G "/etc/wireguard/*.conf" > /dev/null; then
    echo "no config file at /etc/wireguard/*.conf – creating demo config"
    # Generate Server Private Keys
    umask 077
    wg genkey | tee server_private_key | wg pubkey > server_public_key
    # Setup Configuration wg0.conf
    server_pvtkey=$(cat /etc/wireguard/server_private_key)
    
    chown -v root:root /etc/wireguard/wg0.conf
    chmod -v 600 /etc/wireguard/wg0.conf
fi

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

# Configure my network, I think.. I just copied those..

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p udp -m udp --dport 51820 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT

iptables -t nat -A POSTROUTING -s 10.200.200.0/24 -o eth0 -j MASQUERADE

# start the insterface
wg-quick up wg0


# check if Wireguard is running
if [[ $(wg) ]]
then
    syslogd -n      # keep container alive
else
    echo "stopped"  # else exit container
fi
