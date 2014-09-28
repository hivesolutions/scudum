VERSION=${VERSION-2.8.14}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "tcl"

wget "http://download.redis.io/releases/redis-$VERSION.tar.gz"
rm -rf redis-$VERSION && tar -zxf "redis-$VERSION.tar.gz"
rm -f "redis-$VERSION.tar.gz"
cd redis-$VERSION

make PREFIX=$PREFIX && make install
