VERSION=${VERSION-061}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf bootinfoscript-$VERSION && mkdir -p bootinfoscript-$VERSION
cd bootinfoscript-$VERSION

wget "http://downloads.sourceforge.net/bootinfoscript/bootinfoscript-$VERSION.tar.gz"
tar -zxf "bootinfoscript-$VERSION.tar.gz"
rm -f "bootinfoscript-$VERSION.tar.xz"

mkdir -p $PREFIX/bin
cp -p bootinfoscript $PREFIX/bin
