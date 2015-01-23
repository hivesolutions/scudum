# exports the location that is assumed to contain
# the persitent storage sub-filesystem that is going
# to be used for the build process in case it exists
# (this allows for larger builds using volatile system)
export PERSIST=${PERSIST-/pst}

# exports a series of environment variables that
# are going to be used through the build process
export SCUDUM=${SCUDUM-/scudum}
export SCUDUM_TARGET=$(uname -m)-scudum-linux-gnu

# exports the version string value for the current
# distribution in building, the default value is set
# to the currently defined date (to the day value)
export VERSION=${VERSION-$(date +%Y%m%d)}

# exports the generic target value for a pc based
# infra-structure may be used in final scudum build
export PC_TARGET=$(uname -m)-pc-linux-gnu

# exports the unsafe configuration flag so that
# a root user may configure all the packages
export FORCE_UNSAFE_CONFIGURE=1

# exports the flag that defines the level of parallelism
# for the compilation of the various elements, this vaçue
# should be enough to take advantage of the various cores,
# this flag should also be used carefully as it is know to
# create some problems in compilation of some packages
export MAKEFLAGS="-j $(nproc)"

# the flavour to be used for gcc (eg: normal vs latest) note
# that using the latest version make create some compatability
# issues with older cpu based computers
export GCC_FLAVOUR="normal"

# exports the various gcc related flags that will be used to
# define the default/target arch and tune values, note that
# these values are relevant to avoid cross compilation issues
# and make binaries that are able to work across machines
export GCC_DEFAULT_ARCH="x86-64"
export GCC_DEFAULT_TUNE="generic"

# the test value that defines if the current build
# should be done with unit tests runnig (more time)
export TEST=

# the flag value that is going to be used to control if the
# c and c++ compiler flags should be defined statically
export SET_CFLAGS="basic"

# name of the current distribution of sucudum, the default
# value should be generic as no custom deployment is done
export DISTRIB="generic"

# variable that defines the complete set of extra packages
# that are going to be installed when the extras script
# execution is triggered (may be changed by others)
export EXTRAS="sudo python rsync iptables cifs-utils ntfsprogs \
wireless-tools wpa-supplicant"

# exports the flags theat define the deault optimization flags
# for both the base c compiler and the c++ compiler so that the
# resulting build is generic enough for proper handling
if [ "$SET_CFLAGS" == "all" ]; then
    export CFLAGS="-O2 -m64 -march=x86-64 -mtune=generic"
    export CXXFLAGS="-O2 -m64 -march=x86-64 -mtune=generic"
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
        ;;
    normal)
        export GCC_BUILD_BINARY="gcc"
        ;;
    *)
        export GCC_BUILD_BINARY="gcc"
        ;;
esac

print_scudum() {
    echo "PERSIST := $PERSIST"
    echo "SCUDUM := $SCUDUM"
    echo "SCUDUM_TARGET := $SCUDUM_TARGET"
    echo "VERSION := $VERSION"
    echo "PC_TARGET := $PC_TARGET"
    echo "FORCE_UNSAFE_CONFIGURE := $FORCE_UNSAFE_CONFIGURE"
    echo "MAKEFLAGS := $MAKEFLAGS"
    echo "GCC_FLAVOUR := $GCC_FLAVOUR"
    echo "GCC_DEFAULT_ARCH := $GCC_DEFAULT_ARCH"
    echo "GCC_DEFAULT_TUNE := $GCC_DEFAULT_TUNE"
    echo "GCC_BUILD_BINARY := $GCC_BUILD_BINARY"
    echo "TEST := $TEST"
    echo "SET_CFLAGS := $SET_CFLAGS"
    echo "DISTRIB := $DISTRIB"
    echo "EXTRAS := $EXTRAS"
    echo "CFLAGS := $CFLAGS"
    echo "CXXFLAGS := $CXXFLAGS"
}
