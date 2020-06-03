VERSION=${VERSION-2.1-3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget --content-disposition "http://download.sourceforge.net/project/cunit/CUnit-$VERSION.tar.bz2?use_mirror=netcologne"
rm -rf CUnit-$VERSION && tar -jxf "CUnit-$VERSION.tar.bz2"
rm -f "CUnit-$VERSION.tar.bz2"
cd CUnit-$VERSION

autoreconf -f -i
./configure --prefix=$PREFIX
make && make install
