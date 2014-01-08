#!/bin/bash
# -*- coding: utf-8 -*-

# allocates and sets the values of the various
# variables that are going to be used for the
# retrieval and installation of the file
BASE=$1
NAME=${NAME-$BASE}
VERSION=${VERSION-1.0.0}
ARCH=${ARCH-amd64}
URL=${URL-http://repo.stage.hive.pt/scu}
NAME_F="$NAME"_"$VERSION"_"$ARCH"
FILE=$NAME_F.scu

# verifies if a valid name for retrieval has been
# provided if not returns immediately in error
if [ -z "$NAME" ]; then
    echo "No valid name has been provided"
    exit -1
fi

# retrieves the target file from the repository
# and then uses the proper script for installation
wget $URL/$FILE
scu.install $FILE
