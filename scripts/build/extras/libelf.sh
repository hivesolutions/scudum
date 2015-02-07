VERSION=${VERSION-0.8.13}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://www.mr511.de/software/libelf-$VERSION.tar.gz"
rm -rf libelf-$VERSION && tar -zxf "libelf-$VERSION.tar.gz"
rm -f "libelf-$VERSION.tar.gz"
cd libelf-$VERSION

./configure --prefix=$PREFIX
make && make install
