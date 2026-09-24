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
    --prefix=$PREFIX\
    --with-sysroot=$SCUDUM\
    --target=$SCUDUM_TARGET\
    --disable-nls\
    --enable-gprofng=no\
    --disable-werror\
    --enable-new-dtags\
    --enable-default-hash-style=gnu

make && make install
