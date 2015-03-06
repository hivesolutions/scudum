VERSION=${VERSION-2.6.8}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://fastdl.mongodb.org/src/mongodb-linux-x86_64-$VERSION.tgz"
rm -rf mongodb-linux-x86_64-$VERSION && tar -zxf "mongodb-linux-x86_64-$VERSION.tgz"
rm -f "mongodb-linux-x86_64-$VERSION.tgz"
cd mongodb-linux-x86_64-$VERSION

mv bin/* $PREFIX/bin
