set -e +h

mkdir -p $PREFIX_CROSS/bin
mkdir -p $PREFIX_CROSS/lib
mkdir -p $PREFIX_CROSS/sysroot
mkdir -p $PREFIX_CROSS/sysroot/lib
mkdir -p $PREFIX_CROSS/sysroot/usr/lib
mkdir -p $PREFIX_CROSS/sysroot/usr/include
mkdir -p $PREFIX_CROSS/$ARCH_TARGET

ln -svf lib $PREFIX_CROSS/lib32
ln -svf lib $PREFIX_CROSS/lib64
ln -svf lib $PREFIX_CROSS/sysroot/lib32
ln -svf lib $PREFIX_CROSS/sysroot/lib64
ln -svf lib $PREFIX_CROSS/sysroot/usr/lib32
ln -svf lib $PREFIX_CROSS/sysroot/usr/lib64
ln -svf ../sysroot/usr $PREFIX_CROSS/$ARCH_TARGET/usr
ln -svf ../sysroot/lib $PREFIX_CROSS/$ARCH_TARGET/lib
ln -svf lib $PREFIX_CROSS/$ARCH_TARGET/lib32
ln -svf lib $PREFIX_CROSS/$ARCH_TARGET/lib64

rm -f $PREFIX_CROSS/bin/cross-ldd
echo '#!/bin/sh' >> $PREFIX_CROSS/bin/cross-ldd
echo "$ARCH_TARGET-readelf -d \$1 | grep \"Shared library\" | sed \"s/\t//\" | \
cut -d \" \" -f26 | sed \"s/\[//\" | sed \"s/\]//\" | cat" >> $PREFIX_CROSS/bin/cross-ldd
chmod +x $PREFIX_CROSS/bin/cross-ldd
