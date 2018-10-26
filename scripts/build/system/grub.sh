[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-2.02}

set -e +h

unset CFLAGS

wget --no-check-certificate "http://ftp.gnu.org/gnu/grub/grub-$VERSION.tar.xz"
rm -rf grub-$VERSION && tar -Jxf "grub-$VERSION.tar.xz"
rm "grub-$VERSION.tar.xz"
cd grub-$VERSION

./configure\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-grub-emu-usb\
    --disable-efiemu\
    --disable-werror

make && make install
