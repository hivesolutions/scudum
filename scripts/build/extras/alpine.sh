VERSION=${VERSION-2.03}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://prdownloads.sourceforge.net/re-alpine/re-alpine-$VERSION.tar.gz"
rm -rf re-alpine-$VERSION && tar -zxf "re-alpine-$VERSION.tar.gz"
rm -f "re-alpine-$VERSION.tar.gz"
cd re-alpine-$VERSION

./configure --prefix=$PREFIX
make && make install
