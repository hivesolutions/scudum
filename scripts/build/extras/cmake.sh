VERSION=${VERSION-2.8.12.2}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh


wget "http://www.cmake.org/files/v2.8/cmake-$VERSION.tar.gz"
rm -rf cmake-$VERSION && tar -zxf "cmake-$VERSION.tar.gz"
rm -f "cmake-$VERSION.tar.gz"
cd cmake-$VERSION

./bootstrap --prefix=$PREFIX
make && make install
