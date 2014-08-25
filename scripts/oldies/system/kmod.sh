VERSION="12"
tar -Jxf "kmod-$VERSION.tar.xz"
cd kmod-$VERSION

./configure\
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
  ln -sv ../bin/kmod /sbin/$target
done

ln -sv kmod /bin/lsmod

cd ..
rm -rf kmod-$VERSION
