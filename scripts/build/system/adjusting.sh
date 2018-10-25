CC=${CC-gcc}

set -e +h

if [ "$SCUDUM_CROSS" == "0" ]; then
    mv -v /tools/bin/{ld,ld-old}
    mv -v /tools/$ARCH_TARGET/bin/{ld,ld-old}
    mv -v /tools/bin/{ld-new,ld}
    ln -svf /tools/bin/ld /tools/$ARCH_TARGET/bin/ld
fi

# runs a series of replace operation that will make sure that
# the /tools directory is present in the compiler paths
$CC -dumpspecs | sed -e 's@/tools@@g'\
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}'\
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >\
    `dirname $($CC --print-libgcc-file-name)`/specs
