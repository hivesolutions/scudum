VERSION=${VERSION-2.47}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/binutils/$VERSION/binutils-$VERSION.tar.xz"\
    "https://sourceware.org/pub/binutils/releases/binutils-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/binutils/binutils-$VERSION.tar.xz"
rm -rf binutils-$VERSION && tar -Jxf "binutils-$VERSION.tar.xz"
rm -f "binutils-$VERSION.tar.xz"
cd binutils-$VERSION

./configure\
    --prefix=$PREFIX_CROSS\
    --target=$ARCH_TARGET\
    --with-sysroot=$PREFIX_CROSS/sysroot\
    --disable-nls\
    --disable-werror\
    --disable-multilib\
    --without-zstd

make
case $SCUDUM_ARCH in
    arm*|x86_64) mkdir -v $PREFIX/lib && ln -svf lib $PREFIX/lib64 ;;
esac
make install
