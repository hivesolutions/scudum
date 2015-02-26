if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm)
            export CC="$ARCH_TARGET-gcc"
            export CXX="$ARCH_TARGET-g++"
            export AR="$ARCH_TARGET-ar"
            export RANLIB="$ARCH_TARGET-ranlib"
            export LD="$ARCH_TARGET-ld"
            export LD_LIBRARY_PATH="/usr/lib:/lib"
            export PKG_CONFIG_PATH="/usr/lib/pkgconfig:/lib/pkgconfig"
            export CFLAGS="-I/usr/include -I/include -L/usr/lib -L/lib -R/usr/lib -R/lib"
            export CXXFLAGS="-I/usr/include -I/include -L/usr/lib -L/lib -R/usr/lib -R/lib"
            export LDFLAGS="-I/usr/include -I/include -L/usr/lib -L/lib -R/usr/lib -R/lib"
            ;;
    esac
fi
