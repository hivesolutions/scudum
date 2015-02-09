VERSION=${VERSION-9.0.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "mesa"

wget "ftp://ftp.freedesktop.org/pub/mesa/glu/glu-$VERSION.tar.gz"
rm -rf glu-$VERSION && tar -zxf "glu-$VERSION.tar.gz"
rm -f "glu-$VERSION.tar.gz"
cd glu-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
