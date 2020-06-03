VERSION=${VERSION-4.07}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "nasm" "upx" "which"

unset MAKEFLAGS

wget --content-disposition "https://www.kernel.org/pub/linux/utils/boot/syslinux/syslinux-$VERSION.tar.xz"
rm -rf syslinux-$VERSION && tar -Jxf "syslinux-$VERSION.tar.xz"
rm -f "syslinux-$VERSION.tar.xz"
cd syslinux-$VERSION

make
make install\
    INSTALLROOT=$PREFIX\
    BINDIR=/bin\
    LIBDIR=/lib\
    INCDIR=/include\
    MANDIR=/man\
    DATADIR=/share\
    AUXDIR=/lib/syslinux
