#!/bin/sh
# -*- coding: utf-8 -*-

if [ -z "$1" ]; then
    echo "No valid scu file passed"
    exit -1
fi

mkdir /tmp/$1
cp -p $1 /tmp/$1
cd /tmp/$1
ar x $1
mkdir data
mv data.tar.gz /
cd /
tar -zxf data.tar.gz
rm data.tar.gz
rm -rf /tmp/$1
