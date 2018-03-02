VERSION=${VERSION-2.2.5}
VERSION_L=${VERSION_L-2_2_5}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://github.com/libexpat/libexpat/releases/download/R_$VERSION_L/expat-$VERSION.tar.bz2"
rm -rf expat-$VERSION && tar -jxf "expat-$VERSION.tar.bz2"
rm -f "expat-$VERSION.tar.bz2"
cd expat-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
