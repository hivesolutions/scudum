VERSION=${VERSION-4.0.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://download.osgeo.org/libtiff/tiff-$VERSION.tar.gz"
rm -rf tiff-$VERSION && tar -zxf "tiff-$VERSION.tar.gz"
rm -f "tiff-$VERSION.tar.gz"
cd tiff-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
