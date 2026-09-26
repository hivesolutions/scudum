VERSION=${VERSION-26.10.0}
SNAPSHOT=${SNAPSHOT-0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "which" "python3"

rget "https://mirrors.hive.pt/mirrors/scudum/nodejs/$VERSION/node-v$VERSION.tar.xz"\
    "https://nodejs.org/dist/v$VERSION/node-v$VERSION.tar.xz"
rm -rf node-v$VERSION && tar -Jxf "node-v$VERSION.tar.xz"
rm -f "node-v$VERSION.tar.xz"
cd node-v$VERSION

if [ "$SNAPSHOT" == "1" ]; then
    ./configure --prefix=$PREFIX --without-node-snapshot
else
    ./configure --prefix=$PREFIX
fi
make && make install
