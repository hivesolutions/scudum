VERSION=${VERSION-0.32.6}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://cairographics.org/releases/pixman-$VERSION.tar.gz"
rm -rf pixman-$VERSION && tar -zxf "pixman-$VERSION.tar.gz"
rm -f "pixman-$VERSION.tar.gz"
cd pixman-$VERSION

./configure --prefix=$PREFIX
make && make install
