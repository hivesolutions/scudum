VERSION=${VERSION-3.0.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.cmake.org/files/v3.0/cmake-$VERSION.tar.gz"
rm -rf cmake-$VERSION && tar -zxf "cmake-$VERSION.tar.gz"
rm -f "cmake-$VERSION.tar.gz"
cd cmake-$VERSION

./bootstrap --prefix=$PREFIX
make && make install
