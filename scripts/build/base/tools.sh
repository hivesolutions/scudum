#!/bin/bash
# -*- coding: utf-8 -*-

set -e +h

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# runs the complete set of package specific scripts
# in order to build their source code properly
$DIR/../tools/binutils.pass1.sh
$DIR/../tools/$GCC_BUILD_BINARY.pass1.sh
$DIR/../tools/linux-headers.sh
$DIR/../tools/glibc.sh
$DIR/../tools/libstdc++.sh
$DIR/../tools/m4.sh
$DIR/../tools/ncurses.sh
$DIR/../tools/bash.sh
$DIR/../tools/coreutils.sh
$DIR/../tools/diffutils.sh
$DIR/../tools/file.sh
$DIR/../tools/findutils.sh
$DIR/../tools/gawk.sh
$DIR/../tools/grep.sh
$DIR/../tools/gzip.sh
$DIR/../tools/make.sh
$DIR/../tools/patch.sh
$DIR/../tools/sed.sh
$DIR/../tools/tar.sh
$DIR/../tools/xz.sh
$DIR/../tools/openssl.sh
$DIR/../tools/wget.sh
$DIR/../tools/binutils.pass2.sh
$DIR/../tools/$GCC_BUILD_BINARY.pass2.sh

# runs the strip operation on the complete set of tools
# so that some disk space is spared by removing the debug
# and the unneeded symbols from the libraries
$DIR/../tools/strip.sh
