#!/bin/bash
# -*- coding: utf-8 -*-

NAME=${NAME-scudum}
VERSION=${VERSION-latest}
ARCH=${ARCH-x86_64}
REPO=${REPO-http://builds.stage.hive.pt/$NAME}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

# prints an information message about the deployment of the
# (pre-built) root files into the target directory
echo "install: deploying root files into $SCUDUM"

# verifies if any of the special file systems is mounted
# and in case it's unmounts it to avoid extra operations
# to be performed or changed over it
mountpoint -q $SCUDUM/mnt/builds && umount -v $SCUDUM/mnt/builds
mountpoint -q $SCUDUM/sys && umount -v $SCUDUM/sys
mountpoint -q $SCUDUM/proc && umount -v $SCUDUM/proc
mountpoint -q $SCUDUM/run/shm && umount -v $SCUDUM/run/shm
mountpoint -q $SCUDUM/dev/shm && umount -v $SCUDUM/dev/shm
mountpoint -q $SCUDUM/dev/pts && umount -v $SCUDUM/dev/pts
mountpoint -q $SCUDUM/dev && umount -v $SCUDUM/dev

# runs the synchronization operation so that all the pending
# input/output operations are properly flushed (avoids errors)
sync

# removes the tools symbolic link from the current system
# as it's considered to be not required for operation
rm -f /tools

# removes the previously existing scudum implementation
# directory and re-creates it so that it's possible to
# re-deploy it to the newly created directory
rm -rf $SCUDUM && mkdir $SCUDUM

# changes the current directory into the scudum one as the
# various retrieve contents are going to be unpacked there
cd $SCUDUM

# retrieves the requested package containing the scudum root
# files and then unpacks it into the current scudum location,
# this location may then be used as a normal chroot environment
wget --content-disposition "$REPO/$NAME-$ARCH-$VERSION.tar.gz"
tar -zxf $NAME-$ARCH-$VERSION.tar.gz
rm -v $NAME-$ARCH-$VERSION.tar.gz
