#!/bin/sh
# -*- coding: utf-8 -*-

set -e

source /etc/environ

cd /tmp

rm -rf dns_registers && git clone --depth 1 https://github.com/hivesolutions/dns_registers
mkdir -p /etc/bind && rm -rf /etc/bind/dns_registers && mv dns_registers /etc/bind
rm -f /etc/bind/named.conf && ln -s /etc/bind/dns_registers/configuration/named.conf /etc/bind/named.conf
echo "include \"/etc/bind/dns_registers/configuration/hive.conf\";" >> /etc/bind/named.conf
killall -s SIGTERM named > /dev/null 2>&1 || true
named
