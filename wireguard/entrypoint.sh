#!/bin/bash

set -ex

cd /etc/wireguard

function CreatWg0() {
	sed -i "s-SERVER_PVTKEY-${SERVER_PYTKEY}-g" /etc/wireguard/wg0.conf
	sed -i "s-INTERFACE_ADDR-${INTERFACE_ADDR}-g" /etc/wireguard/wg0.conf
}

# Check Config
if ! compgen -G "/etc/wireguard/*.conf" > /dev/null; then
    echo "no config file at /etc/wireguard/*.conf – creating demo config"
    cp /wg0.conf.tpl /etc/wireguard/wg0.conf
    chmod -R 600 /etc/wireguard/*
    # Generate Server Private Keys
    umask 077
    wg genkey | tee server_private_key | wg pubkey > server_public_key
    # Setup Configuration wg0.conf
    SERVER_PYTKEY=$(cat /etc/wireguard/server_private_key)
    CreatWg0
    cat /etc/wireguard/wg0.conf
fi

chown -v root:root /etc/wireguard/wg0.conf
chmod -v 600 /etc/wireguard/wg0.conf

# Configure my network, I think.. I just copied those..
#iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
#iptables -A INPUT -p udp -m udp --dport 51820 -m conntrack --ctstate NEW -j ACCEPT
#iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT
#iptables -t nat -A POSTROUTING -s ${INTERFACE_ADDR}/24 -o eth0 -j MASQUERADE

# Start the Insterface
#wg-quick up wg0
ip link add dev wg0 type wireguard
ip addr add dev wg0 ${INTERFACE_ADDR}/24
wg set wg0 private-key /etc/wireguard/server_private_key listen-port 12345
ip link set up wg0

# Check if Wireguard is Running
if [[ $(wg) ]]
then
    touch /.ready
    syslogd -n
else
    echo "stopped"
fi
