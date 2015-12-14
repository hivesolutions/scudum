#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

BASE=$DIR/..

sudo apt-get update
sudo $BASE/scripts/scudum install
sudo $BASE/scripts/scudum make.iso
