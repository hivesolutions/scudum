VERSION=${VERSION-2.2.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/expat/expat-$VERSION.tar.bz2"
rm -rf expat-$VERSION && tar -jxf "expat-$VERSION.tar.bz2"
rm -f "expat-$VERSION.tar.bz2"
cd expat-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
