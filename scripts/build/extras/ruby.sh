VERSION=${VERSION-2.3.1}
VERSION_L=${VERSION_L-2.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://cache.ruby-lang.org/pub/ruby/$VERSION_L/ruby-$VERSION.tar.gz"
rm -rf ruby-$VERSION && tar -zxf "ruby-$VERSION.tar.gz"
rm -f "ruby-$VERSION.tar.gz"
cd ruby-$VERSION

./configure --prefix=$PREFIX --enable-shared
make && make install
