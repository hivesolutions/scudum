set -e +h

mkdir -p $PREFIX_CROSS/bin
mkdir -p $PREFIX_CROSS/lib
mkdir -p $PREFIX_CROSS/sysroot
mkdir -p $PREFIX_CROSS/sysroot/lib
mkdir -p $PREFIX_CROSS/sysroot/usr/lib
mkdir -p $PREFIX_CROSS/sysroot/usr/include
mkdir -p $PREFIX_CROSS/$ARCH_TARGET

ln -svf ../sysroot/usr $PREFIX_CROSS/$ARCH_TARGET/usr
ln -svf ../sysroot/lib $PREFIX_CROSS/$ARCH_TARGET/lib

rm -f $PREFIX_CROSS/bin/cross-ldd
echo '#!/bin/sh' >> $PREFIX_CROSS/bin/cross-ldd
echo "$ARCH_TARGET-readelf -d \$1 | grep \"Shared library\" | sed \"s/\t//\" | \
cut -d \" \" -f26 | sed \"s/\[//\" | sed \"s/\]//\" | cat" >> $PREFIX_CROSS/bin/cross-ldd
chmod +x $PREFIX_CROSS/bin/cross-ldd
