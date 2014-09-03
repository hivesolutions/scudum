VERSION=${VERSION-0.10.31}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz"
rm -rf node-v$VERSION && tar -zxf "node-v$VERSION.tar.gz"
rm -f "node-v$VERSION.tar.gz"
cd node-v$VERSION

./configure --prefix=$PREFIX
make && make install
