VERSION=${VERSION-0.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://0pointer.de/lennart/projects/libdaemon/libdaemon-$VERSION.tar.gz"
rm -rf libdaemon-$VERSION && tar -zxf "libdaemon-$VERSION.tar.gz"
rm -f "libdaemon-$VERSION.tar.gz"
cd libdaemon-$VERSION

./configure --prefix=$PREFIX

make && make install
