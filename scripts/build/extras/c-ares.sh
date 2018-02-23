VERSION=${VERSION-1.14.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://c-ares.haxx.se/download/c-ares-$VERSION.tar.gz"
rm -rf c-ares-$VERSION && tar -zxf "c-ares-$VERSION.tar.gz"
rm -f "c-ares-$VERSION.tar.gz"
cd c-ares-$VERSION

./configure --prefix=$PREFIX

make && make install
