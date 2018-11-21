#!/bin/bash
# -*- coding: utf-8 -*-

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/base/config.sh

# prints an information message about the removal of the
# (pre-built) root files from the target directory
echo "remove: removing root files from $SCUDUM"

# removes the previously existing scudum implementation
# directory so that it can no longer be used
rm -rf $SCUDUM
