#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

$DIR/install.sh
$DIR/make.iso.sh
