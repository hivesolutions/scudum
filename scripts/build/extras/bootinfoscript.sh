VERSION=${VERSION-061}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rm -rf bootinfoscript-$VERSION && mkdir -p bootinfoscript-$VERSION
cd bootinfoscript-$VERSION

wget --content-disposition "http://download.sourceforge.net/project/bootinfoscript/bootinfoscript-$VERSION.tar.gz?use_mirror=netcologne"
tar -zxf "bootinfoscript-$VERSION.tar.gz"
rm -f "bootinfoscript-$VERSION.tar.xz"

mkdir -p $PREFIX/bin
cp -p bootinfoscript $PREFIX/bin
