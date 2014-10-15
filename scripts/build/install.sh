#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-latest}
REPO=${REPO-http://hq.hive.pt:9999/builds/$NAME}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

# prints an information message about the deployment of the
# (pre-built) root files into the target directory
echo "install: deploying root files into $SCUDUM"

# verifies if any of the special file systems is mounted
# and in case it's unmounts it to avoid extra operations
# to be performed or changed over it
mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

# runs the synchronization operation so that all the pending
# input/ouput operations are properly flushed (avoids errors)
sync

# removes the tools symbolic link from the current system
# as it's considered to be not required for operation
rm -f /tools

# verifies if there's a persist mountpoint enabled for
# the current installation if that's the case it must
# be used for the scudum persistence by using a symbolic
# link into its location, note that for every options the
# scudum installation is first removed (prior to install)
if mountpoint -q $PERSIST; then
    rm -rf $PERSIST$SCUDUM && mkdir $PERSIST$SCUDUM
    rm -f $SCUDUM && ln -s $PERSIST$SCUDUM $SCUDUM
else
    rm -rf $SCUDUM && mkdir $SCUDUM
fi

# changes the current directory into the scudum one as the
# various retrieve contents are going to be unpacked there
cd $SCUDUM

# retrieves the requested package containing the scudum root
# files and then unacks it into the current scudum location,
# this location may then be used as a normal chroot environment
wget "$REPO/$NAME-$VERSION.tar.gz"
tar -zxf $NAME-$VERSION.tar.gz
rm -v $NAME-$VERSION.tar.gz
