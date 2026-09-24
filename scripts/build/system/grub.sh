[ "$SCUDUM_CROSS" == "1" ] && exit 0 || true

VERSION=${VERSION-2.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/../base/functions.sh

unset CFLAGS CPPFLAGS CXXFLAGS LDFLAGS

rgeti "https://mirrors.hive.pt/mirrors/scudum/grub/$VERSION/grub-$VERSION.tar.xz"\
    "https://ftpmirror.gnu.org/grub/grub-$VERSION.tar.xz"
rm -rf grub-$VERSION && tar -Jxf "grub-$VERSION.tar.xz"
rm -f "grub-$VERSION.tar.xz"
cd grub-$VERSION

# disables the broken linker image base check introduced in grub 2.14
sed 's/--image-base/--nonexist-linker-option/' -i configure

./configure\
    --prefix=/usr\
    --sysconfdir=/etc\
    --disable-efiemu\
    --disable-werror

make && make install
