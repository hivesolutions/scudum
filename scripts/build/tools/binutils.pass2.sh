VERSION=${VERSION-2.47}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

rget "https://mirrors.hive.pt/mirrors/scudum/binutils/$VERSION/binutils-$VERSION.tar.xz"\
    "https://sourceware.org/pub/binutils/releases/binutils-$VERSION.tar.xz"
rm -rf binutils-$VERSION && tar -Jxf "binutils-$VERSION.tar.xz"
rm -f "binutils-$VERSION.tar.xz"
cd binutils-$VERSION

sed '6031s/$add_dir//' -i ltmain.sh

mkdir -v build && cd build

../configure\
    --prefix=/usr\
    --build=$(../config.guess)\
    --host=$SCUDUM_TARGET\
    --disable-nls\
    --enable-shared\
    --enable-gprofng=no\
    --disable-werror\
    --enable-64-bit-bfd\
    --enable-new-dtags\
    --enable-default-hash-style=gnu

make && make DESTDIR=$SCUDUM install

rm -v $SCUDUM/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}
