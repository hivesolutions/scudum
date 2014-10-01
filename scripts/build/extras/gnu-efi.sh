VERSION=${VERSION-3.0w}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/gnu-efi/gnu-efi-$VERSION.orig.tar.gz"
rm -rf gnu-efi-$VERSION && tar -zxf "gnu-efi-$VERSION.orig.tar.gz"
rm -f "gnu-efi-$VERSION.orig.tar.gz"
cd gnu-efi-$VERSION

make
install -m 644 gnuefi/*.lds $PREFIX/lib
install -m 644 gnuefi/*.a $PREFIX/lib
