#!/bin/sh
# -*- coding: utf-8 -*-

# veirfies if a valid argument has been passed
# to the process in case it's not prints a mesage
# an exits the current process in error
if [ -z "$1" ]; then
    echo "No valid scu file passed"
    exit -1
fi

# creates a new temporary directory and copies the
# passed file to it then extracts the file as an ar
# (archiver) file and moves the data part of the file
# to the root directory of the file system
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
