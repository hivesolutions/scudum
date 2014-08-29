#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

for package in $EXTRAS; do
    $DIR/extras/$package.sh
done
