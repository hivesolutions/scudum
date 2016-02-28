# exports the location that is assumed to contain
# the persitent storage sub-filesystem that is going
# to be used for the build process in case it exists
# (this allows for larger builds using volatile system)
export PERSIST=${PERSIST-/pst}

# tries to retrive the proper (cpu) architecture from the
# current system in case it has not been provided by the
# user through the command line options (as expected)
export SCUDUM_ARCH=${SCUDUM_ARCH-$(uname -m)}

# uses the base arch value and normalizes it so that the (base) arch
# is more generalized (eg: arm6, arm7, arm8 are all considered arm)
# this is usefull for operations where the general cpu description is
# required instead of the more specific version of the cpu
case "$SCUDUM_ARCH" in
    arm*)
        export SCUDUM_BARCH=arm
        ;;
    *)
        export SCUDUM_BARCH=$SCUDUM_ARCH
        ;;
esac

# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_HOST=${SCUDUM_HOST-$(uname -m)}
export SCUDUM_VENDOR=${SCUDUM_VENDOR-unknown}
export SCUDUM_SYSTEM=${SCUDUM_SYSTEM-linux-gnu}
export SCUDUM_SYSTEM_H=${SCUDUM_SYSTEM_H-linux-gnu}
export SCUDUM_MARCH=${SCUDUM_BARCH//_/-}
export SCUDUM_TARGET=${SCUDUM_TARGET-$SCUDUM_HOST-scudum-$SCUDUM_SYSTEM_H}

# exports the version string value for the current
# distribution in building, the default value is set
# to the currently defined date (to the day value)
export VERSION=${VERSION-$(date +%Y%m%d)}

# exports the generic target value for an arch based
# infra-structure may be used in final scudum build
export ARCH_TARGET=${ARCH_TARGET-$SCUDUM_BARCH-$SCUDUM_VENDOR-$SCUDUM_SYSTEM}

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=${FORCE_UNSAFE_CONFIGURE-1}

# exports the various build oriented values that are going
# to be used to control the build process (the typical build
# process does not require any change to these values)
export BUILD_SAFE=${BUILD_SAFE-0}
export BUILD_CLEAN=${BUILD_CLEAN-1}
export BUILD_TOOLS=${BUILD_TOOLS-1}
export BUILD_CROSS=${BUILD_CROSS-1}
export BUILD_TIMEOUT=${BUILD_TIMEOUT-10}

# exports the flag that defines the level of parallelism
# for the compilation of the various elements, this vaçue
# should be enough to take advantage of the various cores,
# this flag should also be used carefully as it is know to
# create some problems in compilation of some packages
export MAKEFLAGS=${MAKEFLAGS--j $(nproc)}

# the flavour to be used for gcc (eg: normal vs latest) note
# that using the latest version make create some compatability
# issues with older cpu based computers, then defines if the
# multiarch strategy should be used in glibc/gcc generation
# the possible options are enable and disable
export GCC_FLAVOUR=${GCC_FLAVOUR-latest}
export GCC_MULTIARCH=${GCC_MULTIARCH-enable}

# the test value that defines if the current build
# should be done with unit tests runnig (more time)
export TEST=${TEST-}

# the flag value that is going to be used to control if the
# c and c++ compiler flags should be defined statically
export SET_CFLAGS=${SET_CFLAGS-basic}

# name of the current distribution of sucudum, the default
# value should be generic as no custom deployment is done
export DISTRIB="generic"

# variable that defines the complete set of extra packages
# that are going to be installed when the extras script
# execution is triggered (may be changed by others)
export EXTRAS="sudo ntp python lshw rsync iptables logrotate \
cifs-utils ntfsprogs wireless-tools wpa-supplicant"

# verifies the level of matching of the current target arch
# and the hosting one and according to that defines the default
# value to be used in the scudum cross (compilation) flag, note
# that this value may allway be overriden by command line
if [ "$SCUDUM_BARCH" != "$SCUDUM_HOST" ]; then
    export SCUDUM_CROSS=${SCUDUM_CROSS-1}
else
    export SCUDUM_CROSS=${SCUDUM_CROSS-0}
fi

# exports the flags theat define the deault optimization flags
# for both the base c compiler and the c++ compiler so that the
# resulting build is generic enough for proper handling
if [ "$SET_CFLAGS" == "all" ]; then
    export CFLAGS="-O2 -march=$SCUDUM_MARCH -mtune=generic"
    export CXXFLAGS="-O2 -march=$SCUDUM_MARCH -mtune=generic"
fi

# in case the cross compilation mode is active the gcc flavour
# is forced to be normal, so that no compatibility issues arise
# from bugs left by the gnu team (required to build)
if [ "$SCUDUM_CROSS" == "1" ] && [ "$BUILD_SAFE" == "1" ]; then
    export GCC_FLAVOUR="normal"
fi

# verifies if there's a local configuration file if there's
# one runs it's source so that it may be used for other operations
if [ -e config ]; then
    DISTRIB=${PWD##*/}
    source config
fi

# verifies if the persist directory/mountpoint exists and if that's
# the current situation then changes the current scudum directory
# reference to the persist one so that it's possible to spare some
# extra memory, by using secondary storage to store the installation
if [ -e $PERSIST ] && mountpoint -q $PERSIST; then
    export SCUDUM=$PERSIST/scudum
fi

# verifies the target gcc flavour and uses this value to construct
# the proper naming convention for the binary to be built for gcc
case "$GCC_FLAVOUR" in
    latest)
        export GCC_BUILD_BINARY="gcc.latest"
        export GCC_BUILD_VERSION="5.3.0"
        ;;
    normal)
        export GCC_BUILD_BINARY="gcc"
        export GCC_BUILD_VERSION="4.8.5"
        ;;
    *)
        export GCC_BUILD_BINARY="gcc"
        export GCC_BUILD_VERSION="4.8.5"
        ;;
esac

print_scudum() {
    echo "PERSIST := $PERSIST"
    echo "SCUDUM := $SCUDUM"
    echo "SCUDUM_HOST := $SCUDUM_HOST"
    echo "SCUDUM_ARCH := $SCUDUM_ARCH"
    echo "SCUDUM_BARCH := $SCUDUM_BARCH"
    echo "SCUDUM_VENDOR := $SCUDUM_VENDOR"
    echo "SCUDUM_SYSTEM := $SCUDUM_SYSTEM"
    echo "SCUDUM_SYSTEM_H := $SCUDUM_SYSTEM_H"
    echo "SCUDUM_MARCH := $SCUDUM_MARCH"
    echo "SCUDUM_TARGET := $SCUDUM_TARGET"
    echo "SCUDUM_CROSS := $SCUDUM_CROSS"
    echo "VERSION := $VERSION"
    echo "ARCH_TARGET := $ARCH_TARGET"
    echo "FORCE_UNSAFE_CONFIGURE := $FORCE_UNSAFE_CONFIGURE"
    echo "BUILD_SAFE := $BUILD_SAFE"
    echo "BUILD_CLEAN := $BUILD_CLEAN"
    echo "BUILD_TOOLS := $BUILD_TOOLS"
    echo "BUILD_CROSS := $BUILD_CROSS"
    echo "BUILD_TIMEOUT := $BUILD_TIMEOUT"
    echo "MAKEFLAGS := $MAKEFLAGS"
    echo "GCC_FLAVOUR := $GCC_FLAVOUR"
    echo "GCC_MULTIARCH := $GCC_MULTIARCH"
    echo "GCC_BUILD_BINARY := $GCC_BUILD_BINARY"
    echo "GCC_BUILD_VERSION := $GCC_BUILD_VERSION"
    echo "TEST := $TEST"
    echo "SET_CFLAGS := $SET_CFLAGS"
    echo "DISTRIB := $DISTRIB"
    echo "EXTRAS := $EXTRAS"
    echo "CFLAGS := $CFLAGS"
    echo "CXXFLAGS := $CXXFLAGS"
    [ "$GCC_BUILD_ARCH" != "" ] && echo "GCC_BUILD_ARCH := $GCC_BUILD_ARCH" || true
    [ "$GCC_BUILD_CPU" != "" ] && echo "GCC_BUILD_CPU := $GCC_BUILD_CPU" || true
    [ "$GCC_BUILD_TUNE" != "" ] && echo "GCC_BUILD_TUNE := $GCC_BUILD_TUNE" || true
    [ "$GCC_BUILD_FPU" != "" ] && echo "GCC_BUILD_FPU := $GCC_BUILD_FPU" || true
    [ "$GCC_BUILD_FLOAT" != "" ] && echo "GCC_BUILD_FLOAT := $GCC_BUILD_FLOAT" || true
}
