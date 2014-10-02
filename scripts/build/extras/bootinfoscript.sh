VERSION=${VERSION-061}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/bootinfoscript/bootinfoscript-$VERSION.tar.gz"
rm -rf bootinfoscript-$VERSION && tar -zxf "bootinfoscript-$VERSION.tar.gz"
rm -f "syslinux-$VERSION.tar.xz"
cd bootinfoscript-$VERSION

mkdir -p $PREFIX/bin
cp -p bootinfoscript $PREFIX/bin
