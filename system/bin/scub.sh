#!/bin/bash
# -*- coding: utf-8 -*-

# allocates the initial variables that are going
# to be used in the creation and building of the file
TARGET=${TARGET-.}
NAME=${NAME-program}
VERSION=${VERSION-1.0.0}
ARCH=${ARCH-amd64}
HOST=${HOST-files.hive}
USERNAME=${USERNAME-anonymous}
PASSWORD=${PASSWORD-anonymous}
NAME_F=$NAME-$VERSION-$ARCH
FILE=$NAME_F.scu

# changes the current directory to the target one
# and then compresses all of the files contained
# in the directory into the data file (contents)
cd $TARGET
tar -cxf data.tar.gz * > /dev/null

# creates the final archive file with the data file
# contents, the information metadata should be added
# also to the target file to guide it and then removes
# the data file as it's no longer going to be required 
ar cr $FILE data.tar.gz
rm data.tar.gz

# copies the file that was just created into the
# target repository as expected for deployment
scp -q $FILE $USERNAME@$HOST:/scu

# removes the various files used as their are no
# longer going to be required (as expected)
rm $FILE
