VERSION=${VERSION-2.6.4}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

depends "scons"

wget "https://fastdl.mongodb.org/src/mongodb-src-r$VERSION.tar.gz"
rm -rf mongodb-src-r$VERSION && tar -zxf "mongodb-src-r$VERSION.tar.gz"
rm -f "mongodb-src-r$VERSION.tar.gz"
cd mongodb-src-r$VERSION

scons all --ssl
scons install --prefix=$PREFIX
