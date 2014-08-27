#!/bin/bash
# -*- coding: utf-8 -*-

BASE=$(pwd)
DIR=$(dirname $(readlink -f $0))

set -e

source $DIR/base/config.sh

touch $SCUDUM/CONFIGURED

git clone https://github.com/hivesolutions/scudum.git $BASE/scudum.git
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git
