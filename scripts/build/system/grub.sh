VERSION=${VERSION-2.00}

set -e +h

wget --no-check-certificate "http://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.xz"
rm -rf grub-$VERSION && tar -Jxf "grub-$VERSION.tar.xz"
rm "grub-$VERSION.tar.xz"
cd grub-$VERSION

unset CFLAGS

./configure\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-grub-emu-usb\
    --disable-efiemu\
    --disable-werror

make && make install
