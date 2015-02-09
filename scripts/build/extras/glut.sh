VERSION=${VERSION-2.8.1}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glu"

wget "http://downloads.sourceforge.net/freeglut/freeglut-$VERSION.tar.gz"
rm -rf freeglut-$VERSION && tar -zxf "freeglut-$VERSION.tar.gz"
rm -f "freeglut-$VERSION.tar.gz"
cd freeglut-$VERSION

./configure --prefix=$PREFIX --disable-static
make && make install
