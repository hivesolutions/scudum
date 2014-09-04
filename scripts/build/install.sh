#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-latest}
REPO=${REPO-http://hole1.hive:9090/builds/$NAME}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

echo "Installing Scudum root files into $SCUDUM ..."

mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

sync

rm -f /tools
rm -rf $SCUDUM && mkdir $SCUDUM
cd $SCUDUM

wget "$REPO/$NAME-$VERSION.tar.gz"
tar -zxf $NAME-$VERSION.tar.gz
rm -v $NAME-$VERSION.tar.gz
