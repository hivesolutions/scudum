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

# unpacks the data file from the associated file
# should deploy all the file to the root path and
# then runs the cleanup operation removing the current
# temporary directory
tar -zxf data.tar.gz
rm data.tar.gz
rm -rf /tmp/$1

# need to restore the usr to the original
# location, this directory is considered
# immutable and cannot be changed
rm -rf /usr
ln -s cdrom/usr /usr
