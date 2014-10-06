VERSION=${VERSION-10.3.0}
VERSION_L=${VERSION_L-10.3}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "xorg-libs" "libdrm"

wget "ftp://ftp.freedesktop.org/pub/mesa/$VERSION_L/MesaLib-$VERSION.tar.bz2"
rm -rf MesaLib-$VERSION && tar -jxf "MesaLib-$VERSION.tar.bz2"
rm -f "MesaLib-$VERSION.tar.bz2"
cd MesaLib-$VERSION

./configure --prefix=$PREFIX
make && make install
