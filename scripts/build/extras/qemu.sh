VERSION=${VERSION-2.1.2}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "python" "x11"

wget "http://wiki.qemu.org/download/qemu-$VERSION.tar.bz2"
rm -rf qemu-$VERSION && tar -jxf "qemu-$VERSION.tar.bz2"
rm -f "qemu-$VERSION.tar.bz2"
cd qemu-$VERSION

./configure --prefix=$PREFIX --sysconfdir=/etc
make && make install
