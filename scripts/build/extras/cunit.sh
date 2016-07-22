VERSION=${VERSION-2.1-3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/CUnit/CUnit-$VERSION.tar.bz2"
rm -rf CUnit-$VERSION && tar -jxf "CUnit-$VERSION.tar.bz2"
rm -f "CUnit-$VERSION.tar.bz2"
cd CUnit-$VERSION

./configure --prefix=$PREFIX
make && make install
