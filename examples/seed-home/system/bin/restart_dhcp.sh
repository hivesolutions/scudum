#!/bin/sh
# -*- coding: utf-8 -*-

set -e

source /etc/environ

cd /tmp

rm -rf config && git clone --depth 1 https://github.com/hivesolutions/config
mkdir -p /etc/dhcp && rm -rf /etc/dhcp/config && mv config /etc/dhcp
rm -f /etc/dhcp/dhcpd.conf && ln -s /etc/dhcp/config/dhcp/dhcpd.conf /etc/dhcp/dhcpd.conf
mkdir -p /var/lib/dhcpd && touch /var/lib/dhcpd/dhcpd.leases
pushd /etc/dhcp
    killall -s SIGTERM dhcpd > /dev/null 2>&1 || true
    dhcpd -cf /etc/dhcp/dhcpd.conf
popd
