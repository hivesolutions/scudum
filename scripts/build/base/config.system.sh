case "$SCUDUM_ARCH" in
    arm)
        export CC="$ARCH_TARGET-gcc"
        export CXX="$ARCH_TARGET-g++"
        export AR="$ARCH_TARGET-ar"
        export RANLIB="$ARCH_TARGET-ranlib"
        ;;
esac