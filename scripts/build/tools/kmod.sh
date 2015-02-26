VERSION=${VERSION-12}

set -e +h

wget "http://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-$VERSION.tar.xz"
rm -rf kmod-$VERSION && tar -Jxf "kmod-$VERSION.tar.xz"
rm -f "kmod-$VERSION.tar.xz"
cd kmod-$VERSION

./configure\
    --prefix=$PREFIX\
    --bindir=$PREFIX/bin\
    --libdir=$PREFIX/lib\
    --sysconfdir=$PREFIX/etc\
    --disable-manpages\
    --with-xz\
    --with-zlib

make && make pkgconfigdir=$PREFIX/lib/pkgconfig install
