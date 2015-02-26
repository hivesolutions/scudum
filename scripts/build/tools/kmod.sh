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

for target in depmod insmod lsmod modinfo modprobe rmmod; do
    ln -sv ../bin/kmod $PREFIX/sbin/$target
done

ln -sv kmod $PREFIX/bin/lsmod
