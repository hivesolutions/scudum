VERSION=${VERSION-3.0w}
VERSION_L=${VERSION_L-3.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/gnu-efi/gnu-efi_$VERSION.orig.tar.gz"
rm -rf gnu-efi-$VERSION_L && tar -zxf "gnu-efi_$VERSION.orig.tar.gz"
rm -f "gnu-efi_$VERSION.orig.tar.gz"
cd gnu-efi-$VERSION_L

make

ARCH=$(gcc -dumpmachine | cut -f1 -d-| sed s,i[3456789]86,ia32,)

install -m 644 gnuefi/*.lds $PREFIX/lib
install -m 644 gnuefi/*.a $PREFIX/lib

mkdir -p $PREFIX/include/efi
mkdir -p $PREFIX/include/efi/protocol
mkdir -p $PREFIX/include/efi/$ARCH
install -m 644 inc/*.h $PREFIX/include/efi
install -m 644 inc/protocol/*.h $PREFIX/include/efi/protocol
install -m 644 inc/$ARCH/*.h $PREFIX/include/efi/$ARCH
