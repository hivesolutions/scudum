VERSION=${VERSION-2.1.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/expat/expat-$VERSION.tar.gz"
rm -rf expat-$VERSION && tar -zxf "expat-$VERSION.tar.gz"
rm -f "expat-$VERSION.tar.gz"
cd expat-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
