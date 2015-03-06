VERSION=${VERSION-2.6.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://fastdl.mongodb.org/src/mongodb-linux-x86_64-$VERSION.tar.gz"
rm -rf mongodb-linux-x86_64-$VERSION && tar -zxf "mongodb-linux-x86_64-$VERSION.tar.gz"
rm -f "mongodb-linux-x86_64-$VERSION.tar.gz"
cd mongodb-linux-x86_64-$VERSION

mv bin/* $PREFIX/bin
