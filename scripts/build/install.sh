#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-latest}
REPO=${REPO-http://hole1.hive:9090/builds/$NAME}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/base/config.sh

rm -rf $SCUDUM && mkdir $SCUDUM
cd $SCUDUM

wget "$REPO/$NAME-$VERSION.tar.gz"
tar -zxf $NAME-$VERSION.tar.gz
rm -v $NAME-$VERSION.tar.gz
