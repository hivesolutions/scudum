VERSION=${VERSION-2.25}

set -e +h

wget "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

./configure --prefix=$PREFIX_CROSS --with-sysroot=$SCUDUM --with-lib-path=$PREFIX_CROSS/lib\
    --target=$SCUDUM_ARCH --disable-nls --disable-werror

make
case $SCUDUM_ARCH in
    arm|x86_64) mkdir -v $PREFIX/lib && ln -sv lib $PREFIX/lib64 ;;
esac
make install
