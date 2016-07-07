VERSION=${VERSION-2.25.1}

set -e +h

wget "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

./configure --prefix=$PREFIX --with-sysroot=$SCUDUM --with-lib-path=$PREFIX/lib\
    --target=$SCUDUM_TARGET --disable-nls --disable-werror

make
case $SCUDUM_HOST in
    arm*|x86_64) mkdir -v $PREFIX/lib && ln -svf lib $PREFIX/lib64 ;;
esac
make install
