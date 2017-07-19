#!/bin/bash
# -*- coding: utf-8 -*-

# retrieves the reference to the current files directory
# so that it's possible to "write" the scripts as relative
DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

# sets the execution break on error so that if any
# of the commands fails the execution is broken
set -e +h

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

# removes a series of variables from the current environment
# so that no issues occur in the installation of the various
# parts of the root infra-structure and system
unset VERSION
unset LIBRARY_PATH
unset C_INCLUDE_PATH
unset CPLUS_INCLUDE_PATH
unset MANPATH
unset PKG_CONFIG_PATH

# changes the default remembering option and the
# creation mask for the current user
set +h
umask 022

# prints some information about the current configuration
# that is going to be used in the building operation and
# then sleeps for some time (allows reading)
print_scudum
print_scudum_tools
sleep $BUILD_TIMEOUT

# runs the cleanup operation, this should remove any
# previous installation of scudum from the file system
if [ "$BUILD_CLEAN" == "1" ]; then
    $DIR/base/cleanup.sh
fi

# verifies if the current kind of compilation is cross
# based and if that's the case (host is not target) runs
# the cross compilation specific scripts
if [ "$SCUDUM_CROSS" == "1" ] && [ "$BUILD_CROSS" == "1" ]; then
    $DIR/base/cross.sh
fi

# verifies if the current build process is meant to build the
# various tools (base toolchain) and then acts accordingly
if [ "$BUILD_TOOLS" == "1" ]; then
    # runs the complete set of package specific scripts
    # in order to build their source code properly
    $DIR/tools/binutils.pass1.sh
    $DIR/tools/$GCC_BUILD_BINARY.pass1.sh
    $DIR/tools/linux-headers.sh
    $DIR/tools/glibc.sh
    $DIR/tools/libstdc++.sh
    $DIR/tools/binutils.pass2.sh
    $DIR/tools/$GCC_BUILD_BINARY.pass2.sh
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
    $DIR/tools/zlib.sh
    $DIR/tools/pkg-config.sh
    $DIR/tools/util-linux.sh
    $DIR/tools/shadow.sh
    $DIR/tools/e2fsprogs.sh
    $DIR/tools/bc.sh
    $DIR/tools/kmod.sh
    $DIR/tools/openssl.sh
    $DIR/tools/bison.sh
    $DIR/tools/flex.sh
    $DIR/tools/curl.sh
    $DIR/tools/git.sh
    $DIR/tools/wget.sh
    $DIR/tools/gperf.sh

    # runs the strip operation on the complete set of tools
    # so that some disk space is spared by removing the debug
    # and the unneeded symbols from the libraries
    $DIR/tools/strip.sh
fi

# run the output operation that "prints" the current configuration
# into a plain file that it may be latter "sourced"
$DIR/tools/output.sh

# removes the directory where the building process has been done
# so that no extra files leak to the final building stages, then
# deletes also the dynamic link reference in tools (not required)
cd .. && rm -rf build
rm -f /tools
rm -f /cross

# runs the sync command so that the current write operations are
# flushed and further operations reflect the new system state,
# note that the current bash hash state is also cleared
hash -r && sync

# updates the permissions of the tools directory and starts
# the chroot operation in it so that a different execution
# set is started from "now on" (as expected)
chown -R root:root $SCUDUM/tools
if [ -d $SCUDUM/cross ]; then chown -R root:root $SCUDUM/cross; fi
$DIR/base/chroot.sh /tools/repo/scripts/build/base/system.sh

# runs the final strip operation on the generated files so
# that some of the size for the files is spared
$DIR/base/chroot.sh /tools/repo/scripts/build/system/strip.sh
