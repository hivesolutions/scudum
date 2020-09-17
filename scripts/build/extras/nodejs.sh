VERSION=${VERSION-14.11.0}
SNAPSHOT=${SNAPSHOT-0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "which" "python3"

wget --content-disposition "http://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.gz"
rm -rf node-v$VERSION && tar -zxf "node-v$VERSION.tar.gz"
rm -f "node-v$VERSION.tar.gz"
cd node-v$VERSION

if [ "$SNAPSHOT" == "1" ]; then
    ./configure --prefix=$PREFIX --without-snapshot
else
    ./configure --prefix=$PREFIX
fi
make && make install
