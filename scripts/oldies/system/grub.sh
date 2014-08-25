VERSION="2.00"
tar -Jxf "grub-$VERSION.tar.xz"
cd grub-$VERSION

sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

./configure\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-grub-emu-usb\
    --disable-efiemu\
    --disable-werror
make && make install

cd ..
rm -rf grub-$VERSION
