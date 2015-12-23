#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

BASE=$DIR/..

set -e +h

sudo apt-get update
sudo $BASE/scripts/scudum root
sudo $BASE/scripts/scudum make.iso
