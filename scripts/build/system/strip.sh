if [ "$SCUDUM_CROSS" == "1" ]; then
    strip=/cross/bin/$ARCH_TARGET-strip
else
    strip=/tools/bin/strip
fi

/tools/bin/find /{,usr/}{bin,lib,sbin} -type f -exec $strip --strip-debug '{}' ';'
