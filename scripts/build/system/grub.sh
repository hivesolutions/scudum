VERSION=${VERSION-2.0.0}

wget --no-check-certificate "ftp://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.xz"
rm -rf grub-$VERSION && tar -Jxf "grub-$VERSION.tar.xz"
rm "grub-$VERSION.tar.xz"
cd grub-$VERSION

sed -i -e '/gets is a/d' grub-core/gnulib/stdio.in.h

./configure\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-grub-emu-usb\
    --disable-efiemu\
    --disable-werror

make && make install
