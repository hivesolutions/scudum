VERSION=${VERSION-2.1.2}

DIR=$(dirname $(readlink -f $0))

set -e +h

source $DIR/common.sh

wget "http://ruby-lang.org/pub/ruby/2.1/ruby-$VERSION.tar.gz"
rm -rf ruby-$VERSION && tar -zxf "ruby-$VERSION.tar.gz"
rm -f "ruby-$VERSION.tar.gz"
cd ruby-$VERSION

./configure --prefix=$PREFIX
make && make install
