#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-program}
VERSION=${VERSION-1.0.0}
ARCH=${ARCH-amd64}
URL=${URL-http://hole1.hive:9090/repos/scu}
NAME_F=$NAME-$VERSION-$ARCH
FILE=$NAME_F.scu

wget $URL/$FILE
scu.install $FILE
