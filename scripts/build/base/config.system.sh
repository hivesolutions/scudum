case "$SCUDUM_ARCH" in
    arm)
        export CC="$ARCH_TARGET-gcc"
        export CXX="$ARCH_TARGET-g++"
        export AR="$ARCH_TARGET-ar"
        export RANLIB="$ARCH_TARGET-ranlib"
        export LD_LIBRARY_PATH="/usr/lib:/lib"
        export CFLAGS="-I/usr/include -I/include -L/usr/lib -L/lib -R/usr/lib -R/lib"
        export CXXFLAGS="-I/usr/include -I/include -L/usr/lib -L/lib -R/usr/lib -R/lib"
        ;;
esac
