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
install -m 644 gnuefi/*.lds $PREFIX/lib
install -m 644 gnuefi/*.a $PREFIX/lib
