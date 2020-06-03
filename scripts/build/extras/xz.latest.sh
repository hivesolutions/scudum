VERSION=${VERSION-5.2.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

wget --content-disposition "http://tukaani.org/xz/xz-$VERSION.tar.xz"
rm -rf xz-$VERSION && tar -Jxf "xz-$VERSION.tar.xz"
rm -f "xz-$VERSION.tar.xz"
cd xz-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX --libdir=/lib\
    --docdir=/usr/share/doc/xz-$VERSION

make
make pkgconfigdir=$PREFIX/lib/pkgconfig install
