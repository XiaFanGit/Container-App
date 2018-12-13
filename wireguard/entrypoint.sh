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
    CreatWg0
    chown -v root:root /etc/wireguard/wg0.conf
    chmod -v 600 /etc/wireguard/wg0.conf
fi

# Configure my network, I think.. I just copied those..

iptables -A INPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

iptables -A INPUT -p udp -m udp --dport 51820 -m conntrack --ctstate NEW -j ACCEPT
iptables -A FORWARD -i wg0 -o wg0 -m conntrack --ctstate NEW -j ACCEPT

iptables -t nat -A POSTROUTING -s ${interface_addr}/24 -o eth0 -j MASQUERADE

# Start the Insterface
wg-quick up wg0


# Check if Wireguard is Running
if [[ $(wg) ]]
then
    syslogd -n      # keep container alive
else
    echo "stopped"  # else exit container
fi