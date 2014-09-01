#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f $0))

set -e +h

$DIR/install.sh
$DIR/make.iso.sh
