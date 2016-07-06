CC=${CC-gcc}

set -e +h

if [ "SCUDUM_CROSS" == "0" ]; then
    mv -v /tools/bin/{ld,ld-old}
    mv -v /tools/$($CC -dumpmachine)/bin/{ld,ld-old}
    mv -v /tools/bin/{ld-new,ld}
    ln -svf /tools/bin/ld /tools/$($CC -dumpmachine)/bin/ld
fi

$CC -dumpspecs | sed -e 's@/tools@@g'\
    -e '/\*startfile_prefix_spec:/{n;s@.*@/usr/lib/ @}'\
    -e '/\*cpp:/{n;s@$@ -isystem /usr/include@}' >\
    `dirname $($CC --print-libgcc-file-name)`/specs
