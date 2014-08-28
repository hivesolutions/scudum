#!/bin/bash
# -*- coding: utf-8 -*-

# retrieves the reference to the current files directory
# so that it's possible to "write" the scripts as relative
DIR=$(dirname $(readlink -f $0))

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e

# removes any previously existing build directory
# and re-constructs the directory changing into it
rm -rf build && mkdir build
cd build

# installs the dependencies for the various operations
# that are going to be performed in the next steps
$DIR/base/deps.sh

# loads the complete set of environment variables
# that are going to be used in the build process
source $DIR/base/config.sh
source $DIR/base/config.tools.sh

# runs the cleanup operation, this should remove any
# previous installation of scudum from the file system
$DIR/base/cleanup.sh

# changes the default remembering option and the
# creation mask for the current user
set +h
umask 022

# runs the complete set of package specific scripts
# in order to build their source code properly
$DIR/tools/binutils.pass1.sh
$DIR/tools/gcc.pass1.sh
$DIR/tools/linux-headers.sh
$DIR/tools/glibc.sh
#$DIR/tools/libstdcpp.sh
$DIR/tools/binutils.pass2.sh
$DIR/tools/gcc.pass2.sh
$DIR/tools/tcl.sh
$DIR/tools/expect.sh
$DIR/tools/dejagnu.sh
$DIR/tools/check.sh
$DIR/tools/ncurses.sh
$DIR/tools/bash.sh
$DIR/tools/bzip2.sh
$DIR/tools/coreutils.sh
$DIR/tools/diffutils.sh
$DIR/tools/file.sh
$DIR/tools/findutils.sh
$DIR/tools/gawk.sh
$DIR/tools/gettext.sh
$DIR/tools/grep.sh
$DIR/tools/gzip.sh
$DIR/tools/m4.sh
$DIR/tools/make.sh
$DIR/tools/patch.sh
$DIR/tools/perl.sh
$DIR/tools/sed.sh
$DIR/tools/tar.sh
$DIR/tools/texinfo.sh
$DIR/tools/xz.sh
$DIR/tools/openssl.sh
$DIR/tools/wget.sh

# runs the strip operation on the complete set of tools
# so that some disk space is spared by removing the debug
# and the unneeded symbols from the libraries
$DIR/tools/strip.sh

# removes the directory where the building process has been done
# so that no extra files leak to the final building stages
cd .. && rm -rf build

# updates the permissions of the tools directory and starts
# the chroot operation in it so that a different execution
# set is started from "now on" (as expected)
chown -R root:root $SCUDUM/tools
$DIR/base/chroot.sh /tools/repo/scripts/build/base/system.sh

# runs the final strip operation on the generated files so
# that some of the size for the files is spared
$DIR/base/chroot.sh /tools/repo/scripts/build/system/strip.sh
