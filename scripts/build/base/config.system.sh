if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm*)
            export CC="$ARCH_TARGET-gcc"
            export CXX="$ARCH_TARGET-g++"
            export AR="$ARCH_TARGET-ar"
            export RANLIB="$ARCH_TARGET-ranlib"
            export LD="$ARCH_TARGET-ld"
            export CROSSCC="$ARCH_TARGET-gcc"
            export CROSSCXX="$ARCH_TARGET-g++"
            export LD_LIBRARY_PATH="/usr/lib:/lib"
            export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/lib/pkgconfig"
            export CROSSFLAGS="-I/usr/include -I/include -Wl,-rpath,/usr/lib -Wl,-rpath,/lib"
            export LDFLAGS="-L/usr/lib -L/lib"
            export CC="$CC $CROSSFLAGS"
            export CXX="$CXX $CROSSFLAGS"
            ;;
    esac
fi

export EFLAGS=""
export PERL5LIB="/tools/lib/perl5:/tools/lib/perl5/site_perl"

if [ ! -z "$GCC_BUILD_ARCH" ]; then export EFLAGS="$EFLAGS -march=$GCC_BUILD_ARCH"; fi
if [ ! -z "$GCC_BUILD_CPU" ]; then export EFLAGS="$EFLAGS -mcpu=$GCC_BUILD_CPU"; fi
if [ ! -z "$GCC_BUILD_TUNE" ]; then export EFLAGS="$EFLAGS -mtune=$GCC_BUILD_TUNE"; fi
if [ ! -z "$GCC_BUILD_FPU" ]; then export EFLAGS="$EFLAGS -mfpu=$GCC_BUILD_FPU"; fi
if [ ! -z "$GCC_BUILD_FLOAT" ]; then export EFLAGS="$EFLAGS -mfloat-abi=$GCC_BUILD_FLOAT"; fi
if [ "$GCC_BUILD_FLOAT" == "hard" ]; then export EFLAGS="$EFLAGS -D__ARM_PCS_VFP"; fi
if [ "$EFLAGS" != "" ]; then
    if [ -z "$CC" ]; then export CC="gcc"; fi
    if [ -z "$CXX" ]; then export CXX="g++"; fi
    export CC="$CC $EFLAGS"
    export CXX="$CXX $EFLAGS"
fi
