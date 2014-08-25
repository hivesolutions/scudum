#!/bin/bash
# -*- coding: utf-8 -*-

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e

# removes any previously existing build directory
# and re-constructs the directory changing into it
rm -rf build
mkdir build
cd build

# installs the dependencies for the various operations
# that are going to be performed in the next steps
../deps.sh

# loads the complete set of environment variables
# that are going to be used in the build process
source ../base.sh

# creates the proper tools directory where the
# build toolchain is going to be set and sets
# it as the root directory of the system
rm -rf $SCUDUM/tools
rm -rf /tools
mkdir -pv $SCUDUM/tools
ln -sv $SCUDUM/tools /

# changes the default remembering option and the
# creation mask for the current user
set +h
umask 022

# runs the complete set of package specific scripts
# in order to build their source code properly
../tools/binutils.pass1.sh
../tools/gcc.pass1.sh
../tools/linux-headers.sh
../tools/glibc.sh
../tools/binutils.pass2.sh
../tools/gcc.pass2.sh
../tools/tcl.sh
../tools/expect.sh
../tools/dejagnu.sh
../tools/check.sh
../tools/ncurses.sh
../tools/bash.sh
../tools/bzip2.sh
../tools/coreutils.sh
../tools/diffutils.sh
../tools/file.sh
../tools/findutils.sh
../tools/gawk.sh
../tools/gettext.sh
../tools/grep.sh
../tools/gzip.sh
../tools/m4.sh
../tools/make.sh
../tools/patch.sh
../tools/perl.sh
../tools/sed.sh
../tools/tar.sh
../tools/texinfo.sh
../tools/xz.sh

# runs the strip operation on the complete set of tools
# so that some disk space is spared by removing the debug
# and the unneeded symbols from the libraries
../tools/strip.sh

# updates the permissions of the tools directory and starts
# the chroot operation in it so that a different execution
# set is started from "now on" (as expected)
chown -R root:root $SCUDUM/tools
../chroot.sh
