VERSION=${VERSION-1.11}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "libxau" "xcb-proto"

wget "http://xcb.freedesktop.org/dist/libxcb-$VERSION.tar.bz2"
rm -rf libxcb-$VERSION && tar -jxf "libxcb-$VERSION.tar.bz2"
rm -f "libxcb-$VERSION.tar.bz2"
cd libxcb-$VERSION

sed "s/pthread-stubs//" -i configure
./configure\
    --prefix=$PREFIX\
    --sysconfdir=/etc\
    --disable-static\
    --enable-xinput

make && make install
