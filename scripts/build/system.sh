#!/bin/bash
# -*- coding: utf-8 -*-

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e

/tools/repo/scripts/build/system/tree.sh

rm -rf sources
mkdir sources
cd sources

/tools/repo/scripts/build/system/linux-headers.sh
/tools/repo/scripts/build/system/man-pages.sh
/tools/repo/scripts/build/system/glibc.sh
/tools/repo/scripts/build/system/adjusting.sh
/tools/repo/scripts/build/system/zlib.sh
/tools/repo/scripts/build/system/file.sh
/tools/repo/scripts/build/system/binutils.sh
/tools/repo/scripts/build/system/gmp.sh
/tools/repo/scripts/build/system/mpfr.sh
