#!/bin/sh
# -*- coding: utf-8 -*-

set -e

source /etc/environ

cd /tmp

rm -rf dns-registers && git clone --depth 1 https://github.com/hivesolutions/dns-registers
mkdir -p /etc/bind && rm -rf /etc/bind/dns-registers && mv dns-registers /etc/bind
rm -f /etc/bind/named.conf && ln -s /etc/bind/dns-registers/configuration/named.conf /etc/bind/named.conf
echo "include \"/etc/bind/dns-registers/configuration/hive.conf\";" >> /etc/bind/named.conf
killall -s SIGTERM named > /dev/null 2>&1 || true
named
