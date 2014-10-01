VERSION=${VERSION-3.91}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "ucl"

wget "http://upx.sourceforge.net/download/upx-$VERSION-src.tar.bz2"
rm -rf upx-$VERSION-src && tar -jxf "upx-$VERSION-src.tar.bz2"
rm -f "upx-$VERSION-src.tar.bz2"
cd upx-$VERSION-src

make all
cp -p src/upx.out $PREFIX/bin
