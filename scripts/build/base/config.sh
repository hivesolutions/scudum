# exports the location that is assumed to contain
# the persitent storage sub-filesystem that is going
# to be used for the build process in case it exists
# (this allows for larger builds using volatile system)
export PERSIST=${PERSIST-/pst}

# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_HOST=${SCUDUM_HOST-$(uname -m)}
export SCUDUM_ARCH=${SCUDUM_ARCH-$(uname -m)}
export SCUDUM_VENDOR=${SCUDUM_VENDOR-unknown}
export SCUDUM_SYSTEM=${SCUDUM_SYSTEM-linux-gnu}
export SCUDUM_SYSTEM_H=${SCUDUM_SYSTEM_H-linux-gnu}
export SCUDUM_MARCH=${SCUDUM_ARCH//_/-}
export SCUDUM_TARGET=${SCUDUM_TARGET-$SCUDUM_HOST-scudum-$SCUDUM_SYSTEM_H}

# exports the version string value for the current
# distribution in building, the default value is set
# to the currently defined date (to the day value)
export VERSION=${VERSION-$(date +%Y%m%d)}

# exports the generic target value for an arch based
# infra-structure may be used in final scudum build
export ARCH_TARGET=${ARCH_TARGET-$SCUDUM_ARCH-$SCUDUM_VENDOR-$SCUDUM_SYSTEM}

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=${FORCE_UNSAFE_CONFIGURE-1}

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
export EXTRAS="sudo python lshw rsync iptables cifs-utils \
ntfsprogs wireless-tools wpa-supplicant"

# verifies the level of matching of the current target arch
# and the hosting one and according to that defines the default
# value to be used in the scudum cross (compilation) flag, note
# that this value may allway be overriden by command line
if [ "$SCUDUM_ARCH" != "$SCUDUM_HOST" ]; then
    SCUDUM_CROSS=${SCUDUM_CROSS-1}
else
    SCUDUM_CROSS=${SCUDUM_CROSS-0}
fi

# exports the flags theat define the deault optimization flags
# for both the base c compiler and the c++ compiler so that the
# resulting build is generic enough for proper handling
if [ "$SET_CFLAGS" == "all" ]; then
    export CFLAGS="-O2 -march=$SCUDUM_MARCH -mtune=generic"
    export CXXFLAGS="-O2 -march=$SCUDUM_MARCH -mtune=generic"
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
        export GCC_BUILD_VERSION="4.9.2"
        ;;
    normal)
        export GCC_BUILD_BINARY="gcc"
        export GCC_BUILD_VERSION="4.8.4"
        ;;
    *)
        export GCC_BUILD_BINARY="gcc"
        export GCC_BUILD_VERSION="4.8.4"
        ;;
esac

print_scudum() {
    echo "PERSIST := $PERSIST"
    echo "SCUDUM := $SCUDUM"
    echo "SCUDUM_HOST := $SCUDUM_HOST"
    echo "SCUDUM_ARCH := $SCUDUM_ARCH"
    echo "SCUDUM_VENDOR := $SCUDUM_VENDOR"
    echo "SCUDUM_SYSTEM := $SCUDUM_SYSTEM"
    echo "SCUDUM_SYSTEM_H := $SCUDUM_SYSTEM_H"
    echo "SCUDUM_MARCH := $SCUDUM_MARCH"
    echo "SCUDUM_TARGET := $SCUDUM_TARGET"
    echo "SCUDUM_CROSS := $SCUDUM_CROSS"
    echo "VERSION := $VERSION"
    echo "ARCH_TARGET := $ARCH_TARGET"
    echo "FORCE_UNSAFE_CONFIGURE := $FORCE_UNSAFE_CONFIGURE"
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
}
