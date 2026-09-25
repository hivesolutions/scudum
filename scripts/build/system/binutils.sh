VERSION=${VERSION-2.47}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rgeti "https://mirrors.hive.pt/mirrors/scudum/binutils/$VERSION/binutils-$VERSION.tar.xz"\
    "https://sourceware.org/pub/binutils/releases/binutils-$VERSION.tar.xz"
rm -rf binutils-$VERSION && tar -Jxf "binutils-$VERSION.tar.xz"
rm -f "binutils-$VERSION.tar.xz"
cd binutils-$VERSION

cd ..
rm -rf binutils-build && mkdir binutils-build
cd binutils-build

../binutils-$VERSION/configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --sysconfdir=/etc\
    --enable-ld=default\
    --enable-plugins\
    --enable-shared\
    --disable-werror\
    --enable-64-bit-bfd\
    --enable-new-dtags\
    --with-system-zlib\
    --with-lib-path=/usr/lib\
    --enable-default-hash-style=gnu

make tooldir=/usr
test $TEST && make check
make tooldir=/usr install

rm -rfv /usr/lib/lib{bfd,ctf,ctf-nobfd,gprofng,opcodes,sframe}.a\
    /usr/share/doc/gprofng/
