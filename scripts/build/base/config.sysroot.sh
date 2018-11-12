if [ "$SCUDUM_CROSS" == "1" ]; then
    case "$SCUDUM_ARCH" in
        arm*)
            export CC="$CC --sysroot=/"
            export CXX="$CXX --sysroot=/"
            ;;
    esac
fi

export PREFIX="/usr"
