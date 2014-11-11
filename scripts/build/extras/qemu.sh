VERSION=${VERSION-2.1.2}
TARGET_LIST=${TARGET_LIST-x86_64-softmmu,x86_64-linux-user}

DIR=$(dirname $(readlink -f ${BASH_SOURCE[0]}))

set -e +h

source $DIR/common.sh

depends "glib" "python" "x11"

wget "http://wiki.qemu.org/download/qemu-$VERSION.tar.bz2"
rm -rf qemu-$VERSION && tar -jxf "qemu-$VERSION.tar.bz2"
rm -f "qemu-$VERSION.tar.bz2"
cd qemu-$VERSION

./configure --prefix=$PREFIX --target-list=$TARGET_LIST --sysconfdir=/etc
make && make install
