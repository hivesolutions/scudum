set -e +h

mkdir -p $CROSS_PREFIX/lib
mkdir -p $CROSS_PREFIX/sysroot
mkdir -p $CROSS_PREFIX/sysroot/lib
mkdir -p $CROSS_PREFIX/sysroot/usr/lib
mkdir -p $CROSS_PREFIX/sysroot/usr/include
mkdir -p $CROSS_PREFIX/$ARCH_TARGET

ln -svf lib $CROSS_PREFIX/lib32
ln -svf lib $CROSS_PREFIX/lib64
ln -svf lib $CROSS_PREFIX/sysroot/lib32
ln -svf lib $CROSS_PREFIX/sysroot/lib64
ln -svf lib $CROSS_PREFIX/sysroot/usr/lib32
ln -svf lib $CROSS_PREFIX/sysroot/usr/lib64
ln -svf ../sysroot/lib $CROSS_PREFIX/$ARCH_TARGET/lib
ln -svf lib $CROSS_PREFIX/$ARCH_TARGET/lib32
ln -svf lib $CROSS_PREFIX/$ARCH_TARGET/lib64
