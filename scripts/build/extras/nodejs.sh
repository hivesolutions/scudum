VERSION=${VERSION-12.8.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "which"

wget "http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz"
rm -rf node-v$VERSION && tar -zxf "node-v$VERSION.tar.gz"
rm -f "node-v$VERSION.tar.gz"
cd node-v$VERSION

./configure --prefix=$PREFIX --without-snapshot
make && make install
