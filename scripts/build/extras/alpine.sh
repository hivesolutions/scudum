VERSION=${VERSION-2.03}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://downloads.sourceforge.net/re-alpine/re-alpine-$VERSION.tar.bz2"
rm -rf re-alpine-$VERSION && tar -jxf "re-alpine-$VERSION.tar.bz2"
rm -f "re-alpine-$VERSION.tar.bz2"
cd re-alpine-$VERSION

./configure --prefix=$PREFIX
make && make install
