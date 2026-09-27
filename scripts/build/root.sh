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

# verifies that the selected GCC flavour is supported by the
# cross compilation based bootstrap (only latest is supported)
if [ "$GCC_BUILD_BINARY" != "gcc.latest" ]; then
    echo "root: GCC flavour '$GCC_FLAVOUR' is not supported, use 'latest'"
    exit 1
fi

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
    echo "root: starting build process for cross tools..."
    $DIR/base/cross.sh
    echo "root: finished build process for cross tools"
fi

# verifies if the current build process is meant to build the
# various tools (base toolchain) and then acts accordingly
if [ "$BUILD_TOOLS" == "1" ]; then
    echo "root: starting build process for tools..."

    # in case the current build is cross based the tools are a
    # complete host (temporary) root built inside the tools directory
    # of the target root, as its binaries are the ones that run in
    # the chroot while the system is cross compiled, otherwise the
    # tools are built directly into the root (as expected)
    if [ "$SCUDUM_CROSS" == "1" ]; then
        env -u ARCH_TARGET -u SCUDUM_VENDOR -u SCUDUM_SYSTEM\
            -u GCC_BUILD_ARCH -u GCC_BUILD_CPU -u GCC_BUILD_TUNE\
            -u GCC_BUILD_FPU -u GCC_BUILD_FLOAT\
            SCUDUM=$SCUDUM/tools PERSIST=$SCUDUM/tools/pst\
            SCUDUM_ARCH=$SCUDUM_HOST SCUDUM_CROSS=0 BUILD_SYSTEM=0 BUILD_HOST=1\
            $DIR/root.sh
        rm -rf $SCUDUM/tools/tools
    else
        $DIR/base/tools.sh
    fi

    echo "root: finished build process for tools"
fi

# run the output operation that "prints" the current configuration
# into a plain file that it may be latter "sourced" to obtain the
# original setting of the root configuration
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

# builds the temporary tools that could not be cross compiled before
# entering the chroot, for cross builds these are already part of the
# host root in the tools directory (built by its own root operation)
if [ "$SCUDUM_CROSS" == "0" ]; then
    $DIR/base/chroot.sh /tools/repo/scripts/build/base/temporary.sh
fi

# builds the extra tools that the host root of a cross build
# requires to cross compile the system in the target root
if [ "$BUILD_HOST" == "1" ]; then
    $DIR/base/chroot.sh /tools/repo/scripts/build/base/host.sh
fi

# verifies if the current build process is meant to build the final
# system, the host root of a cross build stops at the temporary tools
if [ "$BUILD_SYSTEM" == "1" ]; then
    $DIR/base/chroot.sh /tools/repo/scripts/build/base/system.sh

    # runs the final strip operation on the generated files so
    # that some of the size for the files is spared
    $DIR/base/chroot.sh /tools/repo/scripts/build/system/strip.sh
fi
