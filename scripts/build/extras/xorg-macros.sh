VERSION=${VERSION-1.19.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

wget "http://xorg.freedesktop.org/releases/individual/util/util-macros-$VERSION.tar.bz2"
rm -rf util-macros-$VERSION && tar -jxf "util-macros-$VERSION.tar.bz2"
rm -f "util-macros-$VERSION.tar.bz2"
cd util-macros-$VERSION

./configure --prefix=$PREFIX
make install
