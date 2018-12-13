#!/bin/bash

set -e

cd /etc/wireguard

function CreatWg0() {

sed -i -e "s@^ipv4-network =.*@ipv4-network = ${VPN_NETWORK}@" \
	-e "s@^default-domain =.*@default-domain = ${VPN_DOMAIN}@" \
	-e "s@^ipv4-netmask =.*@ipv4-netmask = ${VPN_NETMASK}@" $CONFIG_FILE
    cat > /etc/wireguard/wg0.conf' <<_EOF
    [Interface]
    Address = $interface_addr/24
    SaveConfig = true
    PrivateKey = $server_pvtkey
    DNS = 8.8.8.8, 119.29.29.29

    [Peer]
    PublicKey = $client_pubkey
    Endpoint = demo.wireguard.com:$server_port
    AllowedIPs = 0.0.0.0/0
    _EOF
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


# check if Wireguard is running
if [[ $(wg) ]]
then
    syslogd -n      # keep container alive
else
    echo "stopped"  # else exit container
fi
