VERSION=${VERSION-0.10.2}
VERSION_L=${VERSION_L-0.10}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxfce4ui" "libxfce4util" "uri"

wget "http://archive.xfce.org/src/xfce/exo/$VERSION_L/exo-$VERSION.tar.bz2"
rm -rf exo-$VERSION && tar -jxf "exo-$VERSION.tar.bz2"
rm -f "exo-$VERSION.tar.bz2"
cd exo-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
