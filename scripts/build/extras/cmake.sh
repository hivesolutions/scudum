VERSION=${VERSION-3.9.0}
VERSION_L=${VERSION_L-3.9}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.cmake.org/files/v$VERSION_L/cmake-$VERSION.tar.gz"
rm -rf cmake-$VERSION && tar -zxf "cmake-$VERSION.tar.gz"
rm -f "cmake-$VERSION.tar.gz"
cd cmake-$VERSION

./bootstrap --prefix=$PREFIX
make && make install
