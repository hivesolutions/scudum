#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-program}
VERSION=${VERSION-1.0.0}
HOST=${USERNAME-files.hive}
USERNAME=${USERNAME-anonymous}
PASSWORD=${PASSWORD-anonymous}
NAME_F=$NAME_$VERSION

tar -cjf $NAME_F.scu *
scp $NAME_F.tar.gz $USERNAME@$HOST:/scu
