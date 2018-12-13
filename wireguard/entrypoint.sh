#!/bin/sh

set -e

(
cd /wireguard/src
echo "Building the wireguard kernel module..."
make module
echo "Installing the wireguard kernel module..."
make module-install
echo "Cleaning up..."
make clean
)

exec $@
