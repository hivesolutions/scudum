VERSION=${VERSION-0.9.0}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libpng" "pango" "gtk+2" "libdrm"

wget "http://www.freedesktop.org/software/plymouth/releases/plymouth-$VERSION.tar.bz2"
rm -rf plymouth-$VERSION && tar -jxf "plymouth-$VERSION.tar.bz2"
rm -f "plymouth-$VERSION.tar.bz2"
cd plymouth-$VERSION

./configure --prefix=$PREFIX --disable-documentation
make && make install
