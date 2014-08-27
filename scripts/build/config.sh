#!/bin/bash
# -*- coding: utf-8 -*-

BASE=$(pwd)

source base/config.sh

git clone https://github.com/hivesolutions/scudum.git $BASE/scudum.git
cp -rpv $BASE/scudum.git/system/* $SCUDUM
rm -rf $BASE/scudum.git
