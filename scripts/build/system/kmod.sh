VERSION=${VERSION-25}

set -e +h

wget --no-check-certificate --content-disposition "http://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-$VERSION.tar.xz"
rm -rf kmod-$VERSION && tar -Jxf "kmod-$VERSION.tar.xz"
rm -f "kmod-$VERSION.tar.xz"
cd kmod-$VERSION

./configure\
    --host=$ARCH_TARGET\
    --prefix=/usr\
    --bindir=/bin\
    --libdir=/lib\
    --sysconfdir=/etc\
    --disable-manpages\
    --with-xz\
    --with-zlib

make
test $TEST && make check
make pkgconfigdir=/usr/lib/pkgconfig install

for target in depmod insmod modinfo modprobe rmmod; do
    ln -svf ../bin/kmod /sbin/$target
done

ln -svf kmod /bin/lsmod
