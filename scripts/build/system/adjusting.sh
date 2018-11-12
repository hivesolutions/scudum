CC=${CC-gcc}

set -e +h

# in case the current environnment is not one of cross compilation
# then some of the /tools binaries are going to be moved to the
# architecture specific directorios (to be compile compliant)
if [ "$SCUDUM_CROSS" == "0" ]; then
    mv -v /tools/bin/{ld,ld-old}
    mv -v /tools/$ARCH_TARGET/bin/{ld,ld-old}
    mv -v /tools/bin/{ld-new,ld}
    ln -svf /tools/bin/ld /tools/$ARCH_TARGET/bin/ld
fi

# runs a series of replace operations that will make sure that
# the /tools directory is present in the compiler paths
if [ "$SCUDUM_CROSS" == "0" ]; the
    $CC -dumpspecs | sed -e 's@/tools@@g'\
        -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}'\
        -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >\
        `dirname $($CC --print-libgcc-file-name)`/specs
fi
