VERSION=${VERSION-3.10.1}
VERSION_L=${VERSION_L-3.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.cmake.org/files/v$VERSION_L/cmake-$VERSION.tar.gz"
rm -rf cmake-$VERSION && tar -zxf "cmake-$VERSION.tar.gz"
rm -f "cmake-$VERSION.tar.gz"
cd cmake-$VERSION

./bootstrap --prefix=$PREFIX
make && make install
