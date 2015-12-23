VERSION=${VERSION-2.6.4}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

rget "http://archive.hive.pt/builds/other/mongodb/mongodb-linux-x86_64-$VERSION.tgz"\
    "https://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$VERSION.tgz"
rm -rf mongodb-linux-x86_64-$VERSION && tar -zxf "mongodb-linux-x86_64-$VERSION.tgz"
rm -f "mongodb-linux-x86_64-$VERSION.tgz"
cd mongodb-linux-x86_64-$VERSION

mv bin/* $PREFIX/bin
