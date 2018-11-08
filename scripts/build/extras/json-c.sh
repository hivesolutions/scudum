VERSION=${VERSION-0.13.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "https://s3.amazonaws.com/json-c_releases/releases/json-c-$VERSION.tar.gz"
rm -rf json-c-$VERSION && tar -zxf "json-c-$VERSION.tar.gz"
rm -f "json-c-$VERSION.tar.gz"
cd json-c-$VERSION

./configure --host=$ARCH_TARGET --prefix=$PREFIX
make && make install
