VERSION=${VERSION-2.25}

set -e +h

wget "http://ftp.gnu.org/gnu/binutils/binutils-$VERSION.tar.bz2"
rm -rf binutils-$VERSION && tar -jxf "binutils-$VERSION.tar.bz2"
rm -f "binutils-$VERSION.tar.bz2"
cd binutils-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --with-sysroot=$SCUDUM --with-lib-path=$PREFIX/lib\
    --target=$SCUDUM_TARGET --disable-nls --disable-werror

make
case $(uname -m) in
    x86_64) mkdir -v $PREFIX/lib && ln -sv lib $PREFIX/lib64 ;;
esac
make install
